def decorateur(fonction):
    def nouvelle_fonction():
        print("Avant l'appel de la fonction")
        fonction()  # Appel de la fonction originale
        print("Après l'appel de la fonction")
    return nouvelle_fonction

@decorateur
def ma_fonction():
    print("À l'intérieur de ma_fonction")

ma_fonction()
