#define BOY 0
#define GIRL 1
typedef struct {
    spinlock_t lock;
    int count[2];
} boygirl_lock_t;

void boygirl_lock_init(boygirl_lock_t *lock) {
    lock->lock = SPIN_LOCK_UNLOCKED;
    lock->count[0] = 0;
    lock->count[1] = 0;
}

void boygirl_lock(boygirl_lock_t *lock, int gender) {
    unsigned long flags;
    while (1) {
        spin_lock_irqsave(lock->lock, flags);
        // another gender is not using 
        if (lock->count[1-gender] == 0) {
            lock->count[gender]++;
            spin_unlock_irqrestore(lock->lock, flags);
            return;
        }
        spin_unlock_irqrestore(lock->lock, flags);
    }
}

void boygirl_unlock(boygirl_lock_t *lock, int gender) {

}