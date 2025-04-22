def get_word_count(request):
    """
    Args:
        request (flask.Request): The request object.

    Returns:
        A response string that includes the number of words in the provided phrase.
    """

    # Parsing the request
    request_json = request.get_json(silent=True)


    # Check if the request provides a 'prompt' key in JSON; otherwise, decode the raw body.
    if request_json and 'prompt' in request_json:
        phrase = request_json['prompt']
    else:
        phrase = request.data.decode('utf-8') if request.data else ''

    # Remove leading/trailing spaces and split the phrase into words.
    words = phrase.strip().split()
    word_count = len(words)

    # Create a response message.
    response_message = (
        f"Your phrase: '{phrase}'\n"
        f"Word count: {word_count}"
    )

    return response_message