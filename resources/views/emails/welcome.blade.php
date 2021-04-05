<html lang="en-US">

<head>
    <meta charset="utf-8">
</head>

<body>
    <h2>
        Hi {{ $data['name'] }}, we’re glad you’re here! Following are your account details: <br>
    </h2>
    <h3>Name: </h3>
    <p>{{ $data['name'] }}</p>
    <h3>Email: </h3>
    <p>{{ $data['email'] }}</p>
    <h3>Password: </h3>
    <p>{{ $data['password'] }}</p>
</body>

</html>
