Received: from mail-yb1-f194.google.com ([209.85.219.194]:33261 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBLE0h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Feb 2019 23:26:37 -0500
MIME-Version: 1.0
References: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
In-Reply-To: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Feb 2019 06:26:24 +0200
Message-ID: <CAOQ4uxh7OayzbGFk0cxoZf_t9jGxesv9k6zPPOA=+5MDsqWOzA@mail.gmail.com>
Subject: Re: Documenting the crash consistency guarantees of file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[CC: linux-fsdevel,linux-doc]

On Sat, Feb 9, 2019 at 12:47 AM Jayashree Mohan <jayashree2912@gmail.com> wrote:
>
> Hi all,
>
> We all understand that providing strong crash consistency guarantees
> while not impacting performance, can be tricky. While you strive to
> achieve that, it is worth documenting the expected/current guarantees
> provided by each file system so that users can report buggy behaviors
> and stop pursuing potential dead ends.
>
> In the course of developing our crash-consistency testing tool:
> CrashMonkey, we've had several interesting discussions with
> file-system developers regarding the guarantees provided by
> file-system operations. For example, the crash-consistency guarantees
> of symlink does not ensure that the symlink-ed file survives a crash,
> even if it was persisted explicitly before the crash. This is because,
> unlike hard links, symlinks are not regular files and it is not
> possible to directly open them to fsync() [1].
>
> Similarly, most file systems today provide guarantees more
> than what the POSIX expects; however, these are not formally
> documented. For example, in btrfs, fsync() of any file should be
> enough to persist that file in its current directory; it does
> not require that its parent directory be explicitly persisted [2].
> f2fs on the other hand, offers multiple fsync() modes like
> FSYNC_MODE_STRICT, FSYNC_MODE_POSIX etc, each with different
> guarantees. As a user, we are unaware of these differences in
> guarantees each file system has to offer.
>
> More recently, there was a bug report which stated that chmod'ed
> permissions on special files were not persisted upon fsync() [3].
> While Ted explained that special files don't have a fsync() function
> defined, thereby making it a no-op, we believe such information is
> crucial and worth documenting.
>
> In this context, how about adding a new file to the Linux kernel
> documentation, for example,
> linux/Documentation/filesystems/crash-consistency-guarantees.txt,
> where developers or users could contribute their knowledge on such
> special cases where persistence guarantees are not applicable, or the
> extent of crash-guarantees each file system provides? If this sounds
> good, we will be happy to send out a patch detailing the information
> we gathered about each file-system's guarantees while testing them
> with CrashMonkey. This would serve as a one-stop destination for all
> information related to crash-consistency guarantees and encourage any
> future conversations pertaining to crash consistency to be documented
> here.
>
> [1] https://www.spinics.net/lists/linux-btrfs/msg76835.html
> [2] https://www.spinics.net/lists/linux-btrfs/msg77340.html
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=202485
>
>

Hi Jayashree,

I think we would be fools to decline an offer for better documentation ;)
Your project has certainly collected some valuable inputs.
The most valuable outcome IMO, besides finding bugs obviously,
is the xfstests that you submitted and working on - ain't nothing like
documentation that checks the code...

But when approaching a task of documenting existing behavior
there are some challenges:
- Behavior may change and documentation may become stale
- Filesystem maintainers may not be happy about committing
  to specific behavior by documenting it

If I were you, I would start with documenting:
1. Existing user space APIs for making changes durable and what
    they guaranty in POSIX vs. Linux (e.g. fsync of symlink)
2. "strictly ordered metadata" - according to Google, Dave Chinner
    was the first to coin this term and claim that ext4, xfs, btrfs all
    abide to those semantics. I think it would be great to have a
    document that describes those semantics, so that we can refer
    people to the doc when trying to explain some crash behavior
    or performance issue that is a by product of these semantics.
3. More tricky would be to find and document behavior that is set in
    stone by applications that grew to expect it despite no guaranty.
    A concrete example is the order guaranties between data and
    metadata operations [1]. I honestly don't know if and what could
    be documented in that regard.

Thanks,
Amir.

[1] https://thunk.org/tytso/blog/2009/03/12/delayed-allocation-and-the-zero-length-file-problem/
