class Duck:
    quackLoudness = 5

    def process(this):
        print "quack!"

class Eagle:
    fishEaten = 0

    def process(this):
        print "screeacch!!"

l = list()

d = Duck()
e = Eagle()

l.append(d)
l.append(e)

for bird in l:
    bird.process()

