<?php

namespace App\Http\Controllers\API\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use App\Mail\WelcomeMail;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;

use App\Http\Controllers\AppBaseController;

class AuthController extends AppBaseController
{
    /**
     * Registrar usuario
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     *
     * @SWG\Post(
     *      path="/signup",
     *      summary="Signup user",
     *      tags={"Auth"},
     *      description="Signup user",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="User that should be signup",
     *          required=true,
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="name",
     *                  description="nombre",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="email",
     *                  description="email",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="password",
     *                  description="password",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="roles",
     *                  description="roles",
     *                  type="number"
     *              )
     *          )
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="message",
     *                  type="string",
     *                  example="Successfully created user!"
     *              )
     *          )
     *      ),
     *      @SWG\Response(
     *          response=422,
     *          description="Unprocessable entity",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="message",
     *                  type="string",
     *                  example="The given data was invalid."
     *              ),
     *              @SWG\Property(
     *                  property="errors",
     *                  description="errors object",
     *                  type="object"
     *              )
     *          )
     *      )
     * )
     */
    public function signUp(Request $request)
    {
        $currentUser = Auth::user();
        if($currentUser->hasRole('admin')){
            $request->validate([
                'name' => 'required|string',
                'email' => 'required|string|email|unique:users',
                'password' => 'required|string',
                'rol' => 'required|exists:roles,id'
            ]);

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => bcrypt($request->password)
            ]);
            $user->assignRole($request->input('rol'));

            // Enviar correo de confirmación de cuenta
            $email = $request->email;
            $data = [
                'name' => $request->name,
                'email' => $request->email,
                'password' => $request->password
            ];
            Mail::to($email)->send(new WelcomeMail($data));
            
            return response()->json([
                'message' => 'Successfully created user!'
            ], 201);
        }
        return $this->sendError("You cannot register users", 401);
    }

    /**
     * Inicio de sesión y generación de token
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * @SWG\Post(
     *      path="/login",
     *      summary="Login user",
     *      tags={"Auth"},
     *      description="Login user",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="User that should be login",
     *          required=true,
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="email",
     *                  description="email",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="password",
     *                  description="password",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="remember_me",
     *                  description="remember password",
     *                  type="boolean",
     *                  example=false
     *              )
     *          )
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="access_token",
     *                  type="string",
     *                  example="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9....."
     *              ),
     *              @SWG\Property(
     *                  property="token_type",
     *                  type="string",
     *                  example="Bearer"
     *              ),
     *              @SWG\Property(
     *                  property="expires_at",
     *                  type="string",
     *                  example="2020-12-18 02:58:28"
     *              )
     *          )
     *      )
     * )
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
            'remember_me' => 'boolean'
        ]);

        $credentials = request(['email', 'password']);

        if (!Auth::attempt($credentials))
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);

        $user = $request->user();
        $tokenResult = $user->createToken('Personal Access Token');

        $token = $tokenResult->token;
        if ($request->remember_me)
            $token->expires_at = Carbon::now()->addWeeks(1);
        $token->save();

        return response()->json([
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse($token->expires_at)->toDateTimeString()
        ]);
    }

    /**
     * Cierre de sesión, inhabilitar token
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * @SWG\Post(
     *      path="/logout",
     *      summary="Logout user",
     *      tags={"Auth"},
     *      description="Logout user",
     *      produces={"application/json"},
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="message",
     *                  type="string",
     *                  example="Successfully logged out"
     *              )
     *          )
     *      )
     * )
     */
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }

    /**
     * Devolver datos del usuario auntenticado
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\
     * 
     * @SWG\Post(
     *      path="/user",
     *      summary="User info",
     *      tags={"User"},
     *      description="User info",
     *      produces={"application/json"},
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="id",
     *                  description="id",
     *                  type="integer",
     *                  format="int32",
     *                  example=1
     *              ),
     *              @SWG\Property(
     *                  property="name",
     *                  description="nombre",
     *                  type="string",
     *                  example="Juan Leal"
     *              ),
     *              @SWG\Property(
     *                  property="email",
     *                  description="email",
     *                  type="string",
     *                  example="juanglealp@gmail.com"
     *              ),
     *              @SWG\Property(
     *                  property="email_verified_at",
     *                  description="email verified at",
     *                  type="boolean",
     *                  example=false
     *              ),
     *              @SWG\Property(
     *                  property="created_at",
     *                  type="string",
     *                  example="2020-11-11T02:47:42.000000Z"
     *              ),
     *              @SWG\Property(
     *                  property="updated_at",
     *                  type="string",
     *                  example="2020-12-11T10:23:12.000000Z"
     *              )
     *          )
     *      )
     * )
     */
    public function user(Request $request)
    {
        $user = $request->user();
        $user->roles = $user->roles()->pluck('name');
        return response()->json($user);
    }

    /**
     * Disable User
     *
     * @param  $id
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * @SWG\Delete(
     *      path="/user/{id}/disable",
     *      summary="Disable user",
     *      tags={"User"},
     *      description="Disable user",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of User",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="message",
     *                  type="string",
     *                  example="User disable successfully"
     *              )
     *          )
     *      )
     * )
     */
    public function disableUser($id, Request $request){
        /** @var User $user */
        $user = User::find($id);

        if (empty($user)) {
            return $this->sendError('User does not exist or is already disabled');
        }
        $currentUser = Auth::user();
        if($currentUser->hasRole('admin')){
            $user->delete();
            return $this->sendSuccess('User disable successfully');
        }
        return $this->sendError("You cannot disable users", 401);
    }

    /**
     * Change password user.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * @SWG\Put(
     *      path="/user/changepassword",
     *      summary="Change password user",
     *      tags={"User"},
     *      description="Change password user",
     *      produces={"application/json"},
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="message",
     *                  type="string",
     *                  example="Password change successfully"
     *              )
     *          )
     *      )
     * )
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'password' => ['required', new MatchOldPassword],
            'new_password' => ['required'],
        ]);   
        User::find(auth()->user()->id)->update(['password'=> Hash::make($request->new_password)]);
        return $this->sendSuccess('Password change successfully');
    }
}
