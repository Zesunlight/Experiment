'''
author: Zhao Yongze
date: November 25
'''

import numpy as np
import matplotlib.pyplot as plt


def initialStrategy(scale, factor):
	matrix = np.random.rand(scale, scale)
	matrix[matrix >= factor] = 1
	matrix[matrix < factor] = 0
	matrix = matrix.astype(int)
	#print(matrix)
	
	return matrix


def payoff(player1, player2 = 0):
	# return: player1's payoff

	T = 2.8  # F(D, C)
	R = 1.1  # F(C, C)
	P = 0.1  # F(D, D)
	S = 0  # F(C, D)

	reward = -1
	if player1 == 0:
		if player2 == 0:
			reward = R
		elif player2 == 1:
			reward = S
	elif player1 == 1:
		if player2 == 0:
			reward = T
		elif player2 == 1:
			reward = P
	
	return reward


def palyGameGetScore(strategy, scale):

	score = np.zeros((scale, scale))

	for i in range(scale):

		for j in range(scale):

			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[i-1][j-1])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[i-1][j])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[i-1][(j+1)%scale])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[i][j-1])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[i][(j+1)%scale])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[(i+1)%scale][j-1])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[(i+1)%scale][j])
			score[i][j] = score[i][j] + payoff(strategy[i][j], strategy[(i+1)%scale][(j+1)%scale])
			
	return score


def switchStrategy(strategy, score, scale):

	new_strategy = strategy

	for i in range(scale):

		for j in range(scale):

			temp_strategy = strategy[i][j]
			temp_score = score[i][j]

			if score[i-1][j-1] > temp_score:
				temp_strategy = strategy[i-1][j-1]
				temp_score = score[i-1][j-1]

			if score[i-1][j] > temp_score:
				temp_strategy = strategy[i-1][j]
				temp_score = score[i-1][j]

			if score[i-1][(j+1)%scale] > temp_score:
				temp_strategy = strategy[i-1][(j+1)%scale]
				temp_score = score[i-1][(j+1)%scale]

			if score[i][j-1] > temp_score:
				temp_strategy = strategy[i][j-1]
				temp_score = score[i][j-1]

			if score[i][(j+1)%scale] > temp_score:
				temp_strategy = strategy[i][(j+1)%scale]
				temp_score = score[i][(j+1)%scale]

			if score[(i+1)%scale][j-1] > temp_score:
				temp_strategy = strategy[(i+1)%scale][j-1]
				temp_score = score[(i+1)%scale][j-1]

			if score[(i+1)%scale][j] > temp_score:
				temp_strategy = strategy[(i+1)%scale][j]
				temp_score = score[(i+1)%scale][j]

			if score[(i+1)%scale][(j+1)%scale] > temp_score:
				temp_strategy = strategy[(i+1)%scale][(j+1)%scale]
				temp_score = score[(i+1)%scale][(j+1)%scale]
				
			new_strategy[i][j] = temp_strategy
		
	new_strategy = new_strategy.astype(int)

	return new_strategy


def generate(generation, strategy, scale):

	for i in range(generation):

		score = palyGameGetScore(strategy, scale)
		#print(score)

		print('generation' + str(i + 1))
		strategy = switchStrategy(strategy, score, scale)
		#print(strategy)

		name = 'dilemma-generation-' + str(i+1) + '.png'
		showMatrix(strategy, name)

	return None


def showMatrix(matrix, save_path = None):

	matrix = np.ones((scale, scale)) - matrix
	matrix = matrix.astype(int)
	plt.imshow(matrix, extent=[0, 200, 0, 200], cmap = 'bone')
	plt.xticks([])
	plt.yticks([])
	plt.axis('off')

	if save_path is not None:
		plt.title(save_path[:-4])
		plt.savefig(save_path)

	return save_path


def desertMakeMatrix(scale, factor):

	matrix = np.random.rand(scale, scale)
	matrix[matrix >= factor] = 1 # 1 means defect, black block
	matrix[matrix < factor] = 0 # 0 means cooperate, white block
	matrix = np.ones((scale, scale)) - matrix
	#print(matrix)

	return matrix

def desertGenerate(number_of_generation, scale, T, R, P, S, F_0, p_c, p_d):

	for i in range(number_of_generation):

		W_c = F_0 + p_c * R + p_d * S
		W_d = F_0 + p_c * T + p_d * P
		W_average = p_c * W_c + p_d * W_d
		p_c = p_c * W_c / W_average
		p_d = p_d * W_d / W_average # p_c + p_d = 1

		dilemma = makeMatrix(scale, p_c)
		name = 'dilemma-generation-' + str(i+1) + '.png'
		showMatrix(dilemma, name)

	return None

def desertPlotFigure(dilemma):
	plt.figure(figsize = (21, 21))

	x = np.linspace(0, len(dilemma)-1, len(dilemma))
	for i in range(len(dilemma)-1, -1, -1):
		x = []
		for j in range(dilemma.shape[1]):
			if dilemma[i][j] == 1:
				x.append(j)
				
		x = np.array(x)
		#print(x)
		y = np.ones(len(x)) + len(dilemma) - 1 - i
		#print(y)
		plt.scatter(x, y, c = 'k')

	plt.xticks([])
	plt.yticks([])
	plt.axis('off')
	#plt.grid(True)
	#plt.savefig('1.png')
	plt.show()
	
	return None


if __name__ == '__main__':

	F_0 = 0 # baseline of the fitness
	p_c = 0.7 # proportion of the population following Cooperate
	p_d = 1 - p_c # proportion of the population following Defect

	scale = 200 # square's length
	number_of_generation = 4

	dilemma = initialStrategy(scale, p_c)
	print('initial dilemma')
	#print(dilemma)
	save_name = 'dilemma-generation-0.png'
	showMatrix(dilemma, save_name)
	generate(number_of_generation, dilemma, scale)