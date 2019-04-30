import numpy as np
import matplotlib.pyplot as plt

class problem_6():
    def __init__(self):
        # Parameters: DO NOT TOUCH THIS METHOD!!!
        self.R = np.array([.9, 0.1, .9, 0.1, 0.1, .9, 0.1, .9]).reshape([8, 1])
        self.P = np.array([[.1, .9, 0, 0],
                           [.9, .1, 0, 0],
                           [.1, 0, .9, 0],
                           [.9, 0, .1, 0],
                           [0, .1, 0, .9],
                           [0, .9, 0, .1],
                           [0, 0, .1, .9],
                           [0, 0, .9, .1]])
        self.pi_rp = np.array([[.5, .5, 0, 0, 0, 0, 0, 0],
                               [0, 0, .5, .5, 0, 0, 0, 0],
                               [0, 0, 0, 0, .5, .5, 0, 0],
                               [0, 0, 0, 0, 0, 0, .5, .5]])

        self.pi_opt = np.array([[1, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 1, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 1, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, 1]])
        self.states = np.array([1, 2, 3, 4])
        self.N_states = 4
        self.N_actions = 2
        self.actions_name = ['right', 'left']
        self.N_features = 2
        assert len(self.actions_name) == self.N_actions
        self.gamma = .9
        self.alpha = .05
        self.v_ini = np.zeros([self.N_states, 1])
        self.q_ini = np.zeros([self.N_states * self.N_actions, 1])

        # Obtain the visiting probability for the random policy
        P_rp = self.pi_rp @ self.P
        w, v = np.linalg.eig(P_rp.T)
        eig_unit = np.argmin(np.abs(w - 1))  # Find the unit eigenvector
        d_v_rp = v[:, eig_unit] / np.sum(v[:, eig_unit])
        assert np.all(d_v_rp >= 0)
        d_q_rp = np.zeros([self.N_states * self.N_actions])
        d_q_rp[::2] = d_v_rp
        d_q_rp[1::2] = d_v_rp
        d_q_rp = d_q_rp * .5
        self.D_q_rp = np.diag(d_q_rp)

        # Obtain the visiting probability for the optimal policy
        P_rp = self.pi_opt @ self.P
        w, v = np.linalg.eig(P_rp.T)
        eig_unit = np.argmin(np.abs(w - 1))  # Find the unit eigenvector
        d_v_op = v[:, eig_unit] / np.sum(v[:, eig_unit])
        assert np.all(d_v_op >= 0)
        d_q_op = np.zeros([self.N_states * self.N_actions])
        d_q_op[0] = d_v_op[0]
        d_q_op[2] = d_v_op[1]
        d_q_op[5] = d_v_op[2]
        d_q_op[7] = d_v_op[3]
        self.D_q_op = np.diag(d_q_op)

        # Initialize other parameters
        self.q_rp = None
        self.q_op = None
        self.q_rp_approx = None
        self.q_op_approx = None
        self.q_est_rp_approx = None
        self.q_est_op_approx = None
        self.v_rp = None
        self.v_op = None
        self.phi_q = None

    def solve_ex_1(self):  # TO BE FINISHED BY STUDENTS
        print('Solutions to the problem 6.1')
        # Solve part 1 of the problem
        self.v_rp, self.q_rp = self.bellman_linear(self.N_states, self.N_actions, self.gamma, self.pi_rp, self.P, self.R)
        self.v_op, self.q_op = self.bellman_linear(self.N_states, self.N_actions, self.gamma, self.pi_opt, self.P, self.R)
        print('P 1 solutions: ')
        print('Random policy: V = ', self.v_rp.reshape([self.N_states]),
              ' ; Q = ', self.q_rp.reshape([self.N_states * self.N_actions]))
        print('Optimal policy: V = ', self.v_op.reshape([self.N_states]),
              ' ; Q = ', self.q_op.reshape([self.N_states * self.N_actions]))

        # Solve part 2 of the problem
        print('P 2 solutions: ')
        for si in range(self.N_states):
            print('Features for state ', self.states[si], ' = ', self.obtain_features(self.states[si]))

        # Solve parts 3 and 4 of the problem
        print('P 3 solutions')
        self.phi_q = np.zeros([self.N_actions * self.N_states, self.N_actions * self.N_features])  # To store features
        i = 0  # Index for the state x action dimension
        for si in range(self.N_states):
            for ac in range(self.N_actions):
                feat = np.zeros(self.N_actions * self.N_features)  # N_actions x n_features
                if ac == 0:
                    feat[0:self.N_features] = # Complete this line
                else:
                    feat[self.N_features:] = # Complete this line
                self.phi_q[i, :] = # Complete this line
                i += 1
                print('Features for state ', self.states[si], ' - action ' + self.actions_name[ac] + '= ', feat)
        print('P 4 solutions: the matrix is ')
        print(self.phi_q)

    def bellman_linear(N_states, N_actions, gamma, policy, P, R): # TO BE FINISHED BY STUDENTS
        v = # Complete this line
        q = # Complete this line
    return v, q

    def obtain_features(self, state, sigma=4): # TO BE FINISHED BY STUDENTS
        features = np.zeros(2)
        features[0] = # Complete this line
        features[1] = # Complete this line
        return features

    def solve_ex_2(self): # TO BE FINISHED BY STUDENTS
        print ('Solution to the problem 6.2')
        # Obtain the BPE solutions: we find the matrices and then, obtain the results for the parameters
        G_rp = # Complete this line
        L_rp = # Complete this line
        z_rp = # Complete this line
        G_opt = # Complete this line
        L_opt = # Complete this line
        z_opt = # Complete this line

        theta_rp = # Complete this line
        theta_opt = # Complete this line
        self.q_rp_approx = self.phi_q @ theta_rp
        print('Random policy Q = ', self.q_rp.reshape([self.N_states * self.N_actions]),
              '; Approximated random policy Q = ', self.q_rp_approx.reshape([self.N_states * self.N_actions]),
              'parameters = ', theta_rp.reshape([self.N_actions * self.N_features]))
        self.q_op_approx = self.phi_q @ theta_opt
        print('Optimal policy Q = ', self.q_op.reshape([self.N_states * self.N_actions]),
              '; Approximated optimal policy Q = ', self.q_op_approx.reshape([self.N_states * self.N_actions]),
              'parameters = ', theta_opt.reshape([self.N_actions * self.N_features]))


    def solve_ex_3(self): # TO BE FINISHED BY STUDENTS
        print ('Solution to the problem 6.3')
        Niter = 500000

        # LSTD estimation of the random policy
        est_G = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_L = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_z = np.zeros([self.N_actions * self.N_features, 1])

        # Implement LSTD algorithm in order to obtain the following vector:
        theta_est_rp = # Complete this line

        self.q_est_rp_approx = self.phi_q @ theta_est_rp
        print('Random policy Q = ', self.q_rp.reshape([self.N_states * self.N_actions]),
              '; LSTD random policy Q = ', self.q_est_rp_approx.reshape([self.N_states * self.N_actions]),
              'parameters = ', theta_est_rp.reshape([self.N_actions * self.N_features]))

        # LSTD estimation of the optimal policy
        est_G = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_L = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_z = np.zeros([self.N_actions * self.N_features, 1])

        # Implement LSTD algorithm in order to obtain the following vector:
        theta_est_opt =  # Complete this line

        self.q_est_op_approx = self.phi_q @ theta_est_opt
        print('Optimal policy Q = ', self.q_op.reshape([self.N_states * self.N_actions]),
              '; LSTD optimal policy Q = ', self.q_est_op_approx.reshape([self.N_states * self.N_actions]),
              'parameters = ', theta_est_opt.reshape([self.N_actions * self.N_features]))

        plt.plot(self.q_rp, 'r', label='Random pol')
        plt.plot(self.q_rp_approx, '--r', label='Random pol, Bellman proj')
        plt.plot(self.q_est_rp_approx, 'r', linewidth=3, alpha=0.5, label='Random pol, LSTD')
        plt.plot(self.q_op, 'b', label='Opt pol')
        plt.plot(self.q_op_approx, '--b', label='Opt pol, Bellman proj')
        plt.plot(self.q_est_op_approx, 'b', linewidth=3, alpha=0.5, label='Opt pol, LSTD')
        plt.legend(loc='best')
        plt.xlabel('State-Actions space')
        plt.ylabel('Q-function')
        plt.title('Comparative: Block solution')
        plt.show()

    def solve_ex_4(self): # TO BE FINISHED BY STUDENTS
        # Solve the problem using online LSPI
        print ('Solution to the problem 6.4')
        def e_greedy(v_input, r, N_actions):
            # Obtain the indexes of the maximum value, take into account possible repetitions
            aux = np.argwhere(v_input == np.amax(v_input)).flatten()
            output = aux[np.random.randint(len(aux))]  # Greedy policy
            u = np.random.rand(1)
            if u < r:
                aux = list(range(N_actions))
                del aux[aux.index(output)]  # Erase max action: this helps exploring when there are few actions
                output = aux[np.random.randint(N_actions - 1)]
            return output  # Return the action index

        e_s = 30000  # Episode size
        Niter = 600000  # Algorithm iterations
        pi_est = np.zeros([self.N_states, Niter])
        theta_est = np.random.randn(self.N_actions * self.N_features, int(Niter / e_s))
        est_G = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_L = np.zeros([self.N_actions * self.N_features, self.N_actions * self.N_features])
        est_z = np.zeros([self.N_actions * self.N_features, 1])

        # Implement LSPI algorithm in order to obtain the following vector:
        theta_est =  # Complete this line with the final feature vector

        q_opt_ite = self.phi_q @ theta_est  # Q evolution

        print('Optimal policy Q = ', self.q_op.reshape([self.N_states * self.N_actions]),
              '; LSTD optimal policy Q = ', self.q_est_op_approx.reshape([self.N_states * self.N_actions]),
              '; LSPI optimal policy Q = ', q_opt_ite.reshape([self.N_states * self.N_actions]))

        plt.plot(self.q_op, 'b', label='Opt pol')
        plt.plot(self.q_op_approx, '--b', label='Opt pol, Bellman proj')
        plt.plot(self.q_est_op_approx, 'b', linewidth=3, alpha=0.5, label='Opt pol, LSTD')
        plt.plot(q_opt_ite, '--b', linewidth=5, alpha=0.5, label='Opt pol, LSPI')
        plt.legend(loc='best')
        plt.xlabel('State-Actions space')
        plt.ylabel('Optimal policy Q-function')
        plt.title('Comparative: Block solution')
        plt.show()

if __name__ == '__main__':
    # Note that each problem depends on the previous ones! You should run them all to avoid errors
    c = problem_6()  # Initialize parameters
    c.solve_ex_1()  # Solves problem 6.1
    c.solve_ex_2()  # Solves problem 6.2
    c.solve_ex_3()  # Solves problem 6.3
    c.solve_ex_4()  # Solves problem 6.4

