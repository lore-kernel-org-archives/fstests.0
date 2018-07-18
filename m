Received: from mail-wr1-f66.google.com ([209.85.221.66]:41198 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbeGRLdm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jul 2018 07:33:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so4200225wrr.8
        for <fstests@vger.kernel.org>; Wed, 18 Jul 2018 03:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0e:d600:a900:9a62:91ee:f856:744c])
        by smtp.gmail.com with ESMTPSA id f18-v6sm4073183wrt.64.2018.07.18.03.56.20
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 03:56:20 -0700 (PDT)
Message-ID: <41c031e69d26666a90221ae0e851581e.f3034ea4@sentimentalizes>
Date: Wed, 18 Jul 2018 13:56:17 +0300
From: spagoveanu@gmail.com
Subject: Re: xfstests can't be installed by running make install
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
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, guaneryu@gmail.com, bug-make@gnu.org
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

This is the same bug I've reported (with a working fix) in

http://lists.gnu.org/archive/html/bug-make/2018-06/msg00009.html

The '[a-z] matching uppercase chars because of LC_COLLATE' aggravating
"feature" is a red herring here; './[a-z]*/' shouldn't match 'makefile'
either; it should only match directories.

> > > [root@fedoravm tmp]#
> 
> GNU make uses the system libc version of the glob(3) and fnmatch(3)
> functions to implement its wildcard function on any system which
> provides GNU libc.
> 
> So, if there's a change which introduces a problem with wildcard it is
> more likely to be related to the GNU libc implementation of glob() or
> fnmatch().

There is a bug in glibc's glob() implementation. Here is a simple test
case that's doing the exactly same things gnu make is doing to trigger it
(use the GLOB_ALTDIRFUNC extension mechanism and set dirent.d_type
to DT_UNKNOWN). The bug can also be triggered without GLOB_ALTDIRFUNC
by using a filesystem without support for the d_type field (eg. minix fs).

$ cc -Wall -O2 glob_onlydir.c -o glob_onlydir
$ mkdir -p test/dir
$ touch test/file
$ ./glob_onlydir 'test/*'
test/dir
test/file
$ cat glob_onlydir.c
#include <stdio.h>
#include <glob.h>
#include <dirent.h>
#include <sys/stat.h>
static void *my_readdir(void *v){
	struct dirent *d = readdir(v);
	if(d) d->d_type = DT_UNKNOWN;
	return d;
}
int main(int ac, char **av){
	int i, j;
	glob_t g = {0};
	g.gl_opendir = (void*(*)(const char*))opendir;
	g.gl_closedir = (void(*)(void*))closedir;
	g.gl_stat = (int(*)(const char*, void*))stat;
	g.gl_lstat = (int(*)(const char*, void*))lstat;
	g.gl_readdir = my_readdir;
	for(i = 1; i < ac; i++)
		if(glob(av[i], GLOB_ONLYDIR|GLOB_ALTDIRFUNC, 0, &g) == 0)
			for(j = 0; j < g.gl_pathc; j++)
				printf("%s\n", g.gl_pathv[j]);
	return 0;
}
