Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfC1Wgu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 18:36:50 -0400
MIME-Version: 1.0
References: <20190328185404.28879-1-fdmanana@kernel.org> <20190328214839.GM26298@dastard>
In-Reply-To: <20190328214839.GM26298@dastard>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2019 22:36:37 +0000
Message-ID: <CAL3q7H6uHcsEvBCTaBaTeCPhsQ2XHDRqVu7tVa-bPc9iHP6pNw@mail.gmail.com>
Subject: Re: [PATCH 2/7] fsstress: add operation for setting xattrs on files
 and directories
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 9:48 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Mar 28, 2019 at 06:54:04PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently fsstress does not exercise creating, reading or deleting xattrs
> > on files or directories. This change adds support for setting xattrs on
> > files and directories, using only the xattr user namespace (the other
> > namespaces are not general purpose and are used for security, capabilities,
> > ACLs, etc). This adds a counter for each file entry structure that keeps
> > track of the number of xattrs set for the file entry, and each new xattr
> > has a name that includes the counter's value (example: "user.x4").
> > Values for the xattrs have at most 100 bytes, which is much more than
> > the maximum size supported for all major filesystems.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  ltp/fsstress.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 141 insertions(+), 9 deletions(-)
> >
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index cc4f520e..03e40eb6 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -27,6 +27,7 @@
> >  io_context_t io_ctx;
> >  #endif
> >  #include <sys/syscall.h>
> > +#include <sys/xattr.h>
> >
> >  #ifndef FS_IOC_GETFLAGS
> >  #define FS_IOC_GETFLAGS                 _IOR('f', 1, long)
> > @@ -85,6 +86,7 @@ typedef enum {
> >       OP_RESVSP,
> >       OP_RMDIR,
> >       OP_SETATTR,
> > +     OP_SETXATTR,
> >       OP_SPLICE,
> >       OP_STAT,
> >       OP_SYMLINK,
> > @@ -110,6 +112,7 @@ typedef struct opdesc {
> >  typedef struct fent {
> >       int     id;
> >       int     parent;
> > +     int     xattr_counter;
> >  } fent_t;
> >
> >  typedef struct flist {
> > @@ -195,6 +198,7 @@ void      rename_f(int, long);
> >  void resvsp_f(int, long);
> >  void rmdir_f(int, long);
> >  void setattr_f(int, long);
> > +void setxattr_f(int, long);
> >  void splice_f(int, long);
> >  void stat_f(int, long);
> >  void symlink_f(int, long);
> > @@ -246,6 +250,7 @@ opdesc_t  ops[] = {
> >       { OP_RESVSP, "resvsp", resvsp_f, 1, 1 },
> >       { OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
> >       { OP_SETATTR, "setattr", setattr_f, 0, 1 },
> > +     { OP_SETXATTR, "setxattr", setxattr_f, 4, 1 },
>
> Ok, now that I see this, the penny drops - you can't do this as
> it changes the CLI interface in a way that will make existing
> scripts do something entirely different to what they used to do.
>
> i.e. "-f setxattr=n" is used to specify the frequency of this
> specific operation. It used to control the project ID setting, now
> with this change it controls extended attribute frequency. There are
> some tests that actually use "-f setxattr=n" (and who knows how many
> custom test scripts using fsstress built from fstests), so I don't
> think we should be renaming existing operations to something else
> and then reusing the name for a new type of operation like this....

Any idea for a good name? (Not too long, or too similar like setextattr)


>
> I certainly agree with the idea of adding extended attributes to
> fsstress, just not this way...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
