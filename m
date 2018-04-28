Received: from mail-yb0-f182.google.com ([209.85.213.182]:45441 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeD1H1h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Apr 2018 03:27:37 -0400
Received: by mail-yb0-f182.google.com with SMTP id r13-v6so1464003ybm.12
        for <fstests@vger.kernel.org>; Sat, 28 Apr 2018 00:27:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427163833.21882-1-jlayton@kernel.org>
References: <20180427163833.21882-1-jlayton@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Apr 2018 00:27:36 -0700
Message-ID: <CAOQ4uxjjjKcsLwML3UkLGaU-LGz_gVxdNRxDotHgSzwPg=2tYg@mail.gmail.com>
Subject: Re: [PATCH] generic: test for seeing unseen fsync errors on newly
 open files
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, willy@infradead.org, andres@anarazel.de, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 9:38 AM, Jeff Layton <jlayton@kernel.org> wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> This adds a regression test for the following kernel patch:
>
>     errseq: Always report a writeback error once
>
> This is motivated by some rather odd behavior done by the PostgreSQL
> project. The main database writers will offload the fsync calls to a
> separate process, which can open files after a writeback error has
> already occurred.
>
> This used to work with older kernels that reported the error to only
> one fd, but with the errseq_t changes we lost the ability to see
> errors that occurred before the open. The above patch restores that
> behavior.
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>
> This patch currently fails on mainline kernels, but I'll be sending
> a pull request to Linus in the near future for the above patch.
>
>  src/Makefile               |   2 +-
>  src/fsync-open-after-err.c | 167 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999          |  95 ++++++++++++++++++++++++++
>  tests/generic/999.out      |   3 +
>  tests/generic/group        |   1 +
>  5 files changed, 267 insertions(+), 1 deletion(-)
>  create mode 100644 src/fsync-open-after-err.c
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
>
> diff --git a/src/Makefile b/src/Makefile
> index 0d3feae1eeb2..3dc9b0da9c3a 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -15,7 +15,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>         holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>         t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>         t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> -       t_ofd_locks
> +       t_ofd_locks fsync-open-after-err
>
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>         preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/fsync-open-after-err.c b/src/fsync-open-after-err.c
> new file mode 100644
> index 000000000000..3dcf936eb94a
> --- /dev/null
> +++ b/src/fsync-open-after-err.c

Jeff,

It is an anti pattern for xfstests to add a single purpose C program
for things that could be implemented otherwise.

AFAICT, This program doesn't do anything that you cannot do with
existing bash helpers and existing programs.

So either add a flag to fsync-err to enable the new test
or use xfs_io fsync (make sure it really returns the error) and
keep file open with bash tricks.

Thanks,
Amir.
