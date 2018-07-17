Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40602 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbeGQFy7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Jul 2018 01:54:59 -0400
Date: Tue, 17 Jul 2018 15:24:08 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180717052408.GZ19934@dastard>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
 <20180715054320.GZ2234@dastard>
 <20180715071110.GH2830@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715071110.GH2830@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 15, 2018 at 03:11:10PM +0800, Eryu Guan wrote:
> On Sun, Jul 15, 2018 at 03:43:20PM +1000, Dave Chinner wrote:
> > On Thu, Jul 12, 2018 at 12:39:21AM +0800, Eryu Guan wrote:
> > > The "wildcard" part is supposed to find all subdirs in tests dir, e.g.
> > > "tests/ext4 tests/generic tests/xfs ...", files shouldn't be included.
> > > So we get subdir list and go into each subdir and do install there.
> > > 
> > > But the same "wildcard" expression returns files too on fedora 28, e.g.
> > > "tests/Makefile tests/ext4 tests/generic tests/xfs ...", as a result,
> > 
> > Should *never* return tests/Makefile, because that does not match
> > the [a-z]* regex - it's a lowercase first character match, not
> > uppercase. And the *only* things that should be in tests/ is the
> > Makefile and all the test subdirs, so it shouldn't be matching the
> > wrong thing. i.e. how are we getting tests/ as a result in the
> > TESTS_SUBDIRS set?
> 
> That's why I think it's a bug of make. I did the following test on
> Fedora 28 with make-4.2.1-6.fc28.x86_64.
> 
> [root@fedoravm tmp]# rpm -q make
> make-4.2.1-6.fc28.x86_64
> [root@fedoravm tmp]# pwd
> /root/tmp
> [root@fedoravm tmp]# ls -l
> total 4
> -rw-r--r--. 1 root root 206 Jul 15 14:58 Makefile
> drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
> [root@fedoravm tmp]# cat Makefile 
> STRING1 = $(wildcard $(CURDIR)/[a-z]*/)
> STRING2 = $(wildcard ./[a-z]*/)
> default:
>         @echo STRING1="$(STRING1)"
>         @echo STRING2="$(STRING2)"
> [root@fedoravm tmp]# make
> STRING1=/root/tmp/testdir/ /root/tmp/Makefile
> STRING2=./testdir/ ./Makefile
> [root@fedoravm tmp]#

So make 4.2.1 on fedora 28 has broken regex matching?

I just ran this on a debian based test machine:

$ make --version
GNU Make 4.1
....
$ make
STRING1=/home/dave/tmp_make/testdir/
STRING2=./testdir/
$

That works, but it's old. I just upgraded it to the lastest unstable
package (4.2.1-1.1), which also upgraded glibc to 2.27-5. Looks like
the make version matches fedora 28, but:

$ make --version
GNU Make 4.2.1
....
$ make
STRING1=/home/dave/tmp_make/testdir/
STRING2=./testdir/
$

the regex behaves correctly. So this looks like it might be
something isolated to the fedora 28 distro package build or glibc
version?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
