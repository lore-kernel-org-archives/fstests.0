Received: from mail-pf0-f196.google.com ([209.85.192.196]:33143 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934025AbeF2Xlw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Jun 2018 19:41:52 -0400
MIME-Version: 1.0
References: <20180629205500.7950-1-paulo@paulo.ac> <20180629205500.7950-2-paulo@paulo.ac>
In-Reply-To: <20180629205500.7950-2-paulo@paulo.ac>
From: Steve French <smfrench@gmail.com>
Date: Fri, 29 Jun 2018 18:41:40 -0500
Message-ID: <CAH2r5msCUKvDsC51ABrnssmkvp=Tcj9cfP4U-spm+S=w-__huw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: Handle OFD locks
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Paulo Alcantara <paulo@paulo.ac>, fstests@vger.kernel.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Paulo,
Did you find out if there were any xfstests for OFD locks, or whether
you could add
one of yours or Jeff's to xfstests for this?
On Fri, Jun 29, 2018 at 3:55 PM Paulo Alcantara <paulo@paulo.ac> wrote:
>
> Correctly check for OFD lock conflicts.
>
> Signed-off-by: Paulo Alcantara <palcantara@suse.de>
> ---
>  fs/cifs/cifsglob.h  |  1 +
>  fs/cifs/cifsproto.h |  4 --
>  fs/cifs/file.c      | 93 ++++++++++++++++++++++++++++++---------------
>  3 files changed, 63 insertions(+), 35 deletions(-)
>
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index a2962fd41c6f..a627559be72e 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1093,6 +1093,7 @@ struct cifsLockInfo {
>         __u64 length;
>         __u32 pid;
>         __u32 type;
> +       unsigned int flags; /* file lock flags*/
>  };
>
>  /*
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 1890f534c88b..870ff791a170 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -214,10 +214,6 @@ extern void cifs_umount(struct cifs_sb_info *);
>  extern void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
>  extern void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
>
> -extern bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset,
> -                                   __u64 length, __u8 type,
> -                                   struct cifsLockInfo **conf_lock,
> -                                   int rw_check);
>  extern void cifs_add_pending_open(struct cifs_fid *fid,
>                                   struct tcon_link *tlink,
>                                   struct cifs_pending_open *open);
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 259167f32580..7c7c505fab3e 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -864,16 +864,17 @@ int cifs_closedir(struct inode *inode, struct file *file)
>  }
>
>  static struct cifsLockInfo *
> -cifs_lock_init(__u64 offset, __u64 length, __u8 type)
> +cifs_lock_init(struct file_lock *flock, __u64 length, __u8 type)
>  {
>         struct cifsLockInfo *lock =
>                 kmalloc(sizeof(struct cifsLockInfo), GFP_KERNEL);
>         if (!lock)
>                 return lock;
> -       lock->offset = offset;
> +       lock->offset = flock->fl_start;
>         lock->length = length;
>         lock->type = type;
>         lock->pid = current->tgid;
> +       lock->flags = flock->fl_flags;
>         INIT_LIST_HEAD(&lock->blist);
>         init_waitqueue_head(&lock->block_q);
>         return lock;
> @@ -893,31 +894,56 @@ cifs_del_lock_waiters(struct cifsLockInfo *lock)
>  #define CIFS_READ_OP   1
>  #define CIFS_WRITE_OP  2
>
> -/* @rw_check : 0 - no op, 1 - read, 2 - write */
> +static inline bool locks_overlap(struct cifsLockInfo *li, __u64 offset,
> +                                __u64 length)
> +{
> +       return offset + length > li->offset &&
> +               li->offset + li->length > offset;
> +}
> +
>  static bool
> -cifs_find_fid_lock_conflict(struct cifs_fid_locks *fdlocks, __u64 offset,
> -                           __u64 length, __u8 type, struct cifsFileInfo *cfile,
> -                           struct cifsLockInfo **conf_lock, int rw_check)
> +locks_conflict(struct cifsFileInfo *cfile, struct cifsFileInfo *cur_cfile,
> +              struct cifsLockInfo *li, __u8 type, unsigned int flags,
> +              struct TCP_Server_Info *server, int rw_check)
> +{
> +       if (rw_check == CIFS_LOCK_OP) {
> +               if (!server->ops->compare_fids(cfile, cur_cfile))
> +                       return true;
> +               if ((flags & FL_FLOCK) && current->tgid == li->pid)
> +                       return false;
> +               if ((flags & FL_OFDLCK) && (li->flags & FL_OFDLCK))
> +                       return false;
> +               if (li->type & server->vals->exclusive_lock_type)
> +                       return true;
> +               if (type & server->vals->exclusive_lock_type)
> +                       return true;
> +               return false;
> +       }
> +
> +       if (server->ops->compare_fids(cfile, cur_cfile) &&
> +           current->tgid == li->pid &&
> +           (!(li->type & server->vals->shared_lock_type) ||
> +            rw_check != CIFS_WRITE_OP))
> +               return false;
> +
> +       return true;
> +}
> +
> +static inline bool
> +__fid_lock_conflicts(struct cifs_fid_locks *fdlocks, __u64 offset, __u64 length,
> +                    __u8 type, unsigned int flags, struct cifsFileInfo *cfile,
> +                    struct cifsLockInfo **conf_lock, int rw_check)
>  {
>         struct cifsLockInfo *li;
>         struct cifsFileInfo *cur_cfile = fdlocks->cfile;
>         struct TCP_Server_Info *server = tlink_tcon(cfile->tlink)->ses->server;
>
>         list_for_each_entry(li, &fdlocks->locks, llist) {
> -               if (offset + length <= li->offset ||
> -                   offset >= li->offset + li->length)
> -                       continue;
> -               if (rw_check != CIFS_LOCK_OP && current->tgid == li->pid &&
> -                   server->ops->compare_fids(cfile, cur_cfile)) {
> -                       /* shared lock prevents write op through the same fid */
> -                       if (!(li->type & server->vals->shared_lock_type) ||
> -                           rw_check != CIFS_WRITE_OP)
> -                               continue;
> -               }
> -               if ((type & server->vals->shared_lock_type) &&
> -                   ((server->ops->compare_fids(cfile, cur_cfile) &&
> -                    current->tgid == li->pid) || type == li->type))
> +               if (!locks_overlap(li, offset, length) ||
> +                   !locks_conflict(cfile, cur_cfile, li, type, flags, server,
> +                                   rw_check))
>                         continue;
> +
>                 if (conf_lock)
>                         *conf_lock = li;
>                 return true;
> @@ -925,18 +951,19 @@ cifs_find_fid_lock_conflict(struct cifs_fid_locks *fdlocks, __u64 offset,
>         return false;
>  }
>
> -bool
> +static bool
>  cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset, __u64 length,
> -                       __u8 type, struct cifsLockInfo **conf_lock,
> -                       int rw_check)
> +                       __u8 type, unsigned int flags,
> +                       struct cifsLockInfo **conf_lock, int rw_check)
>  {
>         bool rc = false;
>         struct cifs_fid_locks *cur;
>         struct cifsInodeInfo *cinode = CIFS_I(d_inode(cfile->dentry));
>
>         list_for_each_entry(cur, &cinode->llist, llist) {
> -               rc = cifs_find_fid_lock_conflict(cur, offset, length, type,
> -                                                cfile, conf_lock, rw_check);
> +               rc = __fid_lock_conflicts(cur, offset, length, type,
> +                                         flags, cfile, conf_lock,
> +                                         rw_check);
>                 if (rc)
>                         break;
>         }
> @@ -964,7 +991,8 @@ cifs_lock_test(struct cifsFileInfo *cfile, __u64 offset, __u64 length,
>         down_read(&cinode->lock_sem);
>
>         exist = cifs_find_lock_conflict(cfile, offset, length, type,
> -                                       &conf_lock, CIFS_LOCK_OP);
> +                                       flock->fl_flags, &conf_lock,
> +                                       CIFS_LOCK_OP);
>         if (exist) {
>                 flock->fl_start = conf_lock->offset;
>                 flock->fl_end = conf_lock->offset + conf_lock->length - 1;
> @@ -1011,7 +1039,8 @@ cifs_lock_add_if(struct cifsFileInfo *cfile, struct cifsLockInfo *lock,
>         down_write(&cinode->lock_sem);
>
>         exist = cifs_find_lock_conflict(cfile, lock->offset, lock->length,
> -                                       lock->type, &conf_lock, CIFS_LOCK_OP);
> +                                       lock->flags, lock->type, &conf_lock,
> +                                       CIFS_LOCK_OP);
>         if (!exist && cinode->can_cache_brlcks) {
>                 list_add_tail(&lock->llist, &cfile->llist->locks);
>                 up_write(&cinode->lock_sem);
> @@ -1307,7 +1336,7 @@ static int cifs_read_flock(struct file_lock *flock, __u32 *type, bool *lock,
>                            bool *wait_flag, struct TCP_Server_Info *server)
>  {
>         unsigned int flags = FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS |
> -               FL_LEASE | FL_CLOSE;
> +               FL_LEASE | FL_CLOSE | FL_OFDLCK;
>
>         if (flock->fl_flags & ~flags) {
>                 cifs_dbg(FYI, "Unknown lock flags 0x%x\n", flock->fl_flags);
> @@ -1318,7 +1347,9 @@ static int cifs_read_flock(struct file_lock *flock, __u32 *type, bool *lock,
>         if (flock->fl_flags & FL_POSIX)
>                 cifs_dbg(FYI, "Posix\n");
>         if (flock->fl_flags & FL_FLOCK)
> -               cifs_dbg(FYI, "Flock\n");
> +               cifs_dbg(FYI, "File lock\n");
> +       if (flock->fl_flags & FL_OFDLCK)
> +               cifs_dbg(FYI, "OFD lock\n");
>         if (flock->fl_flags & FL_ACCESS)
>                 cifs_dbg(FYI, "Process suspended by mandatory locking - not implemented yet\n");
>         if (flock->fl_flags & FL_LEASE)
> @@ -1587,7 +1618,7 @@ static int cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
>         if (lock) {
>                 struct cifsLockInfo *lock;
>
> -               lock = cifs_lock_init(flock->fl_start, length, type);
> +               lock = cifs_lock_init(flock, length, type);
>                 if (!lock)
>                         return -ENOMEM;
>
> @@ -2814,7 +2845,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
>                 goto out;
>
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(from),
> -                                    server->vals->exclusive_lock_type, NULL,
> +                                    server->vals->exclusive_lock_type, 0, NULL,
>                                      CIFS_WRITE_OP))
>                 rc = __generic_file_write_iter(iocb, from);
>         else
> @@ -3385,7 +3416,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
>         down_read(&cinode->lock_sem);
>         if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
>                                      tcon->ses->server->vals->shared_lock_type,
> -                                    NULL, CIFS_READ_OP))
> +                                    0, NULL, CIFS_READ_OP))
>                 rc = generic_file_read_iter(iocb, to);
>         up_read(&cinode->lock_sem);
>         return rc;
> --
> 2.17.1
>


-- 
Thanks,

Steve
