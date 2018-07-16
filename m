Received: from eggs.gnu.org ([208.118.235.92]:40301 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeGPMPl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Jul 2018 08:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <psmith@gnu.org>)
        id 1ff1zX-00025B-Ur
        for fstests@vger.kernel.org; Mon, 16 Jul 2018 07:48:36 -0400
Message-ID: <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
Subject: Re: xfstests can't be installed by running make install
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
Date: Mon, 16 Jul 2018 07:48:26 -0400
In-Reply-To: <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
         <20180711163921.GI2780@desktop> <20180715054320.GZ2234@dastard>
         <20180715071110.GH2830@desktop>
         <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: guaneryu@gmail.com, bug-make@gnu.org
List-ID: <fstests@vger.kernel.org>

On Mon, 2018-07-16 at 15:30 +0800, Zorro Lang wrote:
> > [root@fedoravm tmp]# ls -l
> > total 4
> > -rw-r--r--. 1 root root 206 Jul 15 14:58 Makefile
> > drwxr-xr-x. 1 root root   0 Jul 15 14:59 testdir
> > [root@fedoravm tmp]# cat Makefile 
> > STRING1 = $(wildcard $(CURDIR)/[a-z]*/)
> > STRING2 = $(wildcard ./[a-z]*/)
> > default:
> >          @echo STRING1="$(STRING1)"
> >          @echo STRING2="$(STRING2)"
> > [root@fedoravm tmp]# make
> > STRING1=/root/tmp/testdir/ /root/tmp/Makefile
> > STRING2=./testdir/ ./Makefile
> > [root@fedoravm tmp]#

GNU make uses the system libc version of the glob(3) and fnmatch(3)
functions to implement its wildcard function on any system which
provides GNU libc.

So, if there's a change which introduces a problem with wildcard it is
more likely to be related to the GNU libc implementation of glob() or
fnmatch().

Unless you've somehow compiled GNU make to use its internal version of
GNU glob()/fnmatch() instead of the system version.

I filed a bug about this with GNU libc a long time ago, and it was
apparently fixed in GNU libc 2.19 in 2014.  So, I'm not sure why you've
just started seeing it now.

https://sourceware.org/bugzilla/show_bug.cgi?id=10278
