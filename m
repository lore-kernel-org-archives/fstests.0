Received: from mail-pg1-f195.google.com ([209.85.215.195]:43694 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeGQECp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Jul 2018 00:02:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so8347009pgr.10
        for <fstests@vger.kernel.org>; Mon, 16 Jul 2018 20:32:19 -0700 (PDT)
Date: Tue, 17 Jul 2018 11:32:14 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180717033214.GJ2830@desktop>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180711163921.GI2780@desktop>
 <20180715054320.GZ2234@dastard>
 <20180715071110.GH2830@desktop>
 <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
Sender: fstests-owner@vger.kernel.org
To: Paul Smith <psmith@gnu.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, bug-make@gnu.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 16, 2018 at 07:48:26AM -0400, Paul Smith wrote:
> On Mon, 2018-07-16 at 15:30 +0800, Zorro Lang wrote:
> > > [root@fedoravm tmp]# ls -l
> > > total 4
> > > -rw-r--r--. 1 root root 206 Jul 15 14:58 Makefile
> > > drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
> > > [root@fedoravm tmp]# cat Makefile 
> > > STRING1 = $(wildcard $(CURDIR)/[a-z]*/)
> > > STRING2 = $(wildcard ./[a-z]*/)
> > > default:
> > >          @echo STRING1="$(STRING1)"
> > >          @echo STRING2="$(STRING2)"
> > > [root@fedoravm tmp]# make
> > > STRING1=/root/tmp/testdir/ /root/tmp/Makefile
> > > STRING2=./testdir/ ./Makefile
> > > [root@fedoravm tmp]#
> 
> GNU make uses the system libc version of the glob(3) and fnmatch(3)
> functions to implement its wildcard function on any system which
> provides GNU libc.
> 
> So, if there's a change which introduces a problem with wildcard it is
> more likely to be related to the GNU libc implementation of glob() or
> fnmatch().
> 
> Unless you've somehow compiled GNU make to use its internal version of
> GNU glob()/fnmatch() instead of the system version.
> 
> I filed a bug about this with GNU libc a long time ago, and it was
> apparently fixed in GNU libc 2.19 in 2014.  So, I'm not sure why you've
> just started seeing it now.
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=10278

This problem here doesn't seem the same as the bug above, Fedora 28 has
glibc-2.27, which contains the fix for above bug, and the bug is about
trailing "/". But the problem here is we're asking for all lower case
filenames but wildcard returns upper case names too. e.g.

[root@fedoravm tmp]# pwd
/root/tmp
[root@fedoravm tmp]# ls -l
total 4
-rw-r--r--. 1 root root   0 Jul 17 10:51 aaa
-rw-r--r--. 1 root root   0 Jul 17 10:51 AAA
-rw-r--r--. 1 root root 273 Jul 17 10:50 Makefile
drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
[root@fedoravm tmp]# cat Makefile
STRING1 = $(wildcard $(CURDIR)/[a-z]*/)
STRING2 = $(wildcard ./[a-z]*/)
STRING3 = $(wildcard $(CURDIR)/[a-z]*/.)
STRING4 = $(wildcard $(CURDIR)/[a-z]*)
default:
        @echo STRING1="$(STRING1)"
        @echo STRING2="$(STRING2)"
        @echo STRING3="$(STRING3)"
        @echo STRING4="$(STRING4)"
[root@fedoravm tmp]# make
STRING1=/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir/ /root/tmp/Makefile
STRING2=./aaa ./AAA ./testdir/ ./Makefile
STRING3=/root/tmp/testdir/.
STRING4=/root/tmp/aaa /root/tmp/AAA /root/tmp/testdir /root/tmp/Makefile
[root@fedoravm tmp]#

STRING4 is asking for all lower file names, but both "AAA" and
"Makefile" are returned.

Thanks,
Eryu
