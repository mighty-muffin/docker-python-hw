from app.msg import print_message


def test_print_message(capsys):
    print_message("Hello World from Docker!")
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello World from Docker!"
