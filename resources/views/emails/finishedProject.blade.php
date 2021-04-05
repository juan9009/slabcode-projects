<html lang="en-US">

<head>
    <meta charset="utf-8">
</head>

<body>
    <h2>
        The project named "{{ $data->name }}" has ended<br>
    </h2>
    <h3>Description: </h3>
    <p>{{ $data->description }}</p>
    <h3>Start Date: </h3>
    <p>{{ $data->start_date }}</p>
    <h3>End Date: </h3>
    <p>{{ $data->end_date }}</p>
</body>

</html>
