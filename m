Received: from imap.thunk.org ([74.207.234.97]:51226 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbeDJDMq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Apr 2018 23:12:46 -0400
Date: Mon, 9 Apr 2018 23:12:42 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: Directory unremovable on ext4 no_journal mode
Message-ID: <20180410031242.GA3563@thunk.org>
References: <CA+EzBbCXWZZiP2jBnUQSn8LeTkav0tEJ-ra60GiVNxZK8zhLmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EzBbCXWZZiP2jBnUQSn8LeTkav0tEJ-ra60GiVNxZK8zhLmg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: linux-ext4@vger.kernel.org, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 09, 2018 at 07:08:13PM -0500, Jayashree Mohan wrote:
> Hi,
>=20
> We stumbled upon what seems to be a bug that makes a =E2=80=9Cdirectory
> unremovable=E2=80=9D,  on ext4 when mounted with no_journal option.

Hi Jayashree,

If you use no_journal mode, you **must** run e2fsck after a crash.
And you do have to potentially be ready for data loss after a crash.
So no, this isn't a bug.  The guarantees that you have when use
no_journal is essentially limited to what Posix specifies when you
crash uncleanly --- "the results are undefined".

> The sequence of operations listed above is making dir Z unremovable
> from dir Y, which seems like unexpected behavior. Could you provide
> more details on the reason for such behavior? We understand we run
> this on no_journal mode of ext4, but would like you to verify if this
> behavior is acceptable.

We use no_journal mode in Google, but we are preprared to effectively
reinstall the root partition, and we are prepared to lose data on our
data disks, after a crash.  We are OK with this because all persistent
data stored on machines is data we are prepared to lose (e.g., cached
data or easily reinstalled system software) or part of our cluster
file system, where we use erasure codes to assure that data in the
cluster file system can remain accessible even if (a) a disk dies
completely, or (b) the entry router on the rack dies, denying access
to all of the disks in a rack from the cluster file system until the
router can be repaired.  So losing a file or a directory after running
e2fsck after a crash is actually small beer compared to any number of
other things that can happen to a disk.

The goal for no_journal mode is performance at all costs, and we are
prepared to sacrifice file system robustness after a crash.  This
means we aren't doing any kind of FUA writes or CACHE FLUSH
operations, because those would compromise performance.  (As a thought
experiment, I would encouraging you to try to design a file system
that would provide better guarantees without using FUA writes, CACHE
FLUSH operations, and with the HDD's write-back cache enabled.)

To understand why this is so important, I would recommend that you
read the "Disks for Data Center" paper[1].  There is also a lot of
good stuff in the FAST 2016 keynote that isn't in the paper or the
slides.  So listening to the audio recording is also something I
strongly commend for people who want to understand Google's approach
to storage.  (Before 2016, we had always considered this part of our
"secret sauce" that we had never disclosed for the past decade, since
it is what gave us a huge storage TCO advantage over other companies.)

[1] https://research.google.com/pubs/pub44830.html
[2] https://www.usenix.org/node/194391

Essentially, we are trying to use all of the two baskets of value
provided by each HDD.  That is, we want to use nearly all of the byte
capacity and all of the IOPS that an HDD can provide --- and FUA
writes or CACHE FLUSHES significantly compromises the number of I/O
operations the HDD can provide.  (More details about how we do this at
the cluster level can be found in the PDSW 2017 keynote[3], but it
goes well beyond the scope of what gets done on a single file system
on a single HDD.)

[3] http://www.pdsw.org/pdsw-discs17/slides/PDSW-DISCS-Google-Keynote.pdf

Regards,

						- Ted

P.S.  This is not to say that the work you are doing with Crashmonkey
et. al. is not useless; it's just not applicable for a cluster file
system in a hyper-scale cloud environment.  Local disk file systems
and robustness after a crash is still important in applications such
as Android and Chrome OS, for example.  Note that we do *not* use
no_journal mode in those environments.  :-)
