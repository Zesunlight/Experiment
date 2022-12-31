'''
author: Zhao Yongze
date: November 29
'''

import numpy as np
import matplotlib.pyplot as plt


def payoff(player1, player2):
    reward = 0
    if player1 + player2 > 10:
        reward = 0
    else:
        reward = player1
    
    return reward


def calculateReward(p):
    w = np.zeros(len(p))
    for i in range(len(p)):
        for j in range(len(p)):
            w[i] = w[i] + payoff(i, j) * p[j]
    
    return w


def calculateReward(p):
    w = np.zeros(len(p))
    for i in range(len(p)):
        for j in range(len(p)):
            w[i] = w[i] + payoff(i, j) * p[j]
    
    return w


def calculateAverage(w, p):
    w_average = 0
    for i in range(len(w)):
        w_average = w_average + w[i] * p[i]
    
    return w_average


def updateFrequency(w, p, w_average):
    new_p = p.copy()
    for i in range(len(p)):
        new_p[i] = p[i] * w[i] / w_average

    return new_p


def generate(p, generation):

	history_p = p
	history_w = []
	history_w_average = []

	for i in range(generation):
	    #print(str(i) + ' generation')
	    
	    w = calculateReward(p)
	    #print(w)
	    history_w.append(w)
	    
	    w_average = calculateAverage(w, p)
	    #print(w_average)
	    history_w_average.append(w_average)
	    
	    p = updateFrequency(w, p, w_average)
	    #print(p, np.sum(p))
	    history_p = np.vstack((history_p, p))
    
	#print('history_p\n', history_p)
	history_w = np.array(history_w)
	#print('history_w\n', history_w)
	history_w_average = np.array(history_w_average)
	#print('history_w_average\n', history_w_average)

	return history_p, history_w, history_w_average


def figure(history_p):
	x = np.arange(len(history_p))

	fig = plt.figure(figsize = (10, 6), dpi = 80)
	plt.title('The evolution of unequal division')
	for i in range(len(p)):
	    plt.plot(x, history_p[:, i], label = 'Demand ' + str(i))
	plt.legend()
	plt.xlabel('Time')
	plt.ylabel('Frequency in population')
	plt.show()
	# plt.savefig('cake.png')

	return None

if __name__ == '__main__':

	# p = np.array([0.0544685, 0.236312, 0.0560727, 0.0469244, 0.0562243, 0.0703294, 
 #        	0.151136, 0.162231, 0.0098273, 0.111366, 0.0451093])
	#p = np.array([0.410376, 0.107375, 0.0253916, 0.116684, 0.0813494, 0.00573677, 
	#              0.0277155, 0.0112791, 0.0163166, 0.191699, 0.00607705])
	# p = np.array([0.1]*11)
	# p[0] = 0.05
	# p[10] = 0.05
	p = np.array([0.2, 0.1 , 0.1,  0.05,  0.05,  0.05,  0.05 , 0.05 , 0.05 , 0.1,  0.2])
	# p = np.random.rand(11)
	# s = np.sum(p)
	# p = p / s
	print(p)
	generation = 40
	history_p, history_w, history_w_average = generate(p, generation)
	figure(history_p)