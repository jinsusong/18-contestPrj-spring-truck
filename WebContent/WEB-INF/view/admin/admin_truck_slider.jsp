<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>Sly example</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sly/1.6.1/sly.min.js"></script>
    <style>
        .frame {
            height: 250px;
            line-height: 250px;
            overflow: hidden;
        }
        .frame ul {
            list-style: none;
            margin: 0;
            padding: 0;
            height: 100%;
            font-size: 50px;
        }
        .frame ul li {
            float: left;
            width: 227px;
            height: 100%;
            margin: 0 1px 0 0;
            padding: 0;
            background: #f2f2f2;
            color: #ddd;
            text-align: center;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="frame">
    <ul class="slidee">
    </ul>
</div>
<script>
    var sly = new Sly($('.frame'), {
        horizontal: 1, // required
        itemNav: 'basic', // required
        smart: 1,
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        scrollBy: 1,
        speed: 300,
        elasticBounds: 1,
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1
    }, null).init();
    var counter = 0;
    setInterval(function () {
        $('.slidee').append('<li>'+(counter++)+'</li>');
        sly.reload();
    }, 500);
</script>
</body>
</html>