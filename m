Received: from imap.thunk.org ([74.207.234.97]:55276 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbdLIQCc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 9 Dec 2017 11:02:32 -0500
Date: Sat, 9 Dec 2017 11:02:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171209160219.ax3jc3n5fmuxnwvz@thunk.org>
References: <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <20171207235922.GJ5858@dastard>
 <20171208001302.GK21978@ZenIV.linux.org.uk>
 <CAOQ4uxj=amYQBnOrcYTLCs4_8gN_+ZkiRu8u45tOEd+v9mHvtw@mail.gmail.com>
 <20171208225757.GP4094@dastard>
 <CAOQ4uxjNiC1YKvfr1c_2eyUhpwHHU1zFnpSerKmxw5Y5B0aLCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjNiC1YKvfr1c_2eyUhpwHHU1zFnpSerKmxw5Y5B0aLCA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>, Byungchul Park <byungchul.park@lge.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 09, 2017 at 10:44:33AM +0200, Amir Goldstein wrote:
> The honest truth is that loop nested fs can *really* cause a
> deadlock with silly setups.  completion lockdep is the unlucky
> messenger that was trying to bring that to our attention.

What is the "silly setup" (I'm not saying kernel bugs, but rather
things which a sysadmin might want to set up) that would cause
deadlock?  In the example you gave, the block allocation is happenig
in two different file system instances, so if lockdep whinges, that's
another example of a false positive.

> Byungchul,
> 
> Seeing how your changes to lockdep completion has caused pain to fs developers,
> I recommend that when checking your changes you run Ted's kvm-xfstests to
> verify it is not causing any regressions w.r.t. false positive lockdep warnings.
> This test VM is specifically designed for other subsystem developers to
> easily run the fs subsystem testsuite.

How about a Kconfig to disable completion lockdep?  It's clearly not
ready for prime time.

At the *minimum*, block devices and struct supers need to have the
ability to have unique id's, and there needs to be a trivial way to
mix that into lockdep key that doesn't require every single subsystem
and device driver author to use undocumented lockdep interfaces to
make the right thing happen.  Instead, we need abstractions that make
the right thing happen by default.

Until this happens, we either need to disable lockdep completions, or
disable lockdep altogether.  I'd prefer the former --- and I'll even
offer to run a Kconfig fixup patch through the ext4 tree to do this,
"free of charge" --- but if you NACK such a change, I'll probably end
up following Dave Chinner's wise counsel and suggest to all ext4
developers to disable lockdep.

							- Ted
