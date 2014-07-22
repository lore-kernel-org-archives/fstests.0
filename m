Return-Path: <fstests-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:55550 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaGVQIG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 22 Jul 2014 12:08:06 -0400
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 97D676491A
	for <fstests@vger.kernel.org>; Tue, 22 Jul 2014 16:07:58 +0000 (UTC)
Received: from g2t2360.austin.hp.com (g2t2360.austin.hp.com [16.197.8.247])
	by g2t2352.austin.hp.com (Postfix) with ESMTP id 8D6FC110
	for <fstests@vger.kernel.org>; Tue, 22 Jul 2014 16:07:33 +0000 (UTC)
Received: from beardog.cce.hp.com (beardog.cce.hp.com [16.84.84.24])
	by g2t2360.austin.hp.com (Postfix) with ESMTP id 7454256
	for <fstests@vger.kernel.org>; Tue, 22 Jul 2014 16:07:33 +0000 (UTC)
Date: Tue, 22 Jul 2014 11:06:41 -0500
From: scameron@beardog.cce.hp.com
Subject: Problem building xfsprogs
Message-ID: <20140722160641.GU17967@beardog.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: scameron@beardog.cce.hp.com
List-ID: <fstests@vger.kernel.org>


I'm trying to build xfsprogs (in order to run xfstests), and I'm running into this:

[scameron@localhost xfsprogs]$ git log --oneline | head -1
ba24eb7 logprint: Fix printing of AGF and AGI buffers
[scameron@localhost xfsprogs]$ git pull
Already up-to-date.
[scameron@localhost xfsprogs]$ git diff
[scameron@localhost xfsprogs]$ ./configure
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking for gcc... gcc
checking for C compiler default output file name... a.out

[...snip...]

checking for library containing blkid_probe_all... -lblkid
checking for blkid_probe_get_topology... yes
checking for readdir... yes
checking size of long... 8
checking size of char *... 8
checking for __psint_t ... no
checking for __psunsigned_t ... no
checking for __u32 ... yes
checking for umode_t... yes
configure: creating ./config.status
config.status: creating include/builddefs
config.status: creating include/platform_defs.h
config.status: include/platform_defs.h is unchanged
config.status: executing libtool commands
[scameron@localhost xfsprogs]$ make
Building include
Building libxfs
gmake[2]: *** No rule to make target `.ltdep', needed by `ltdepend'.  Stop.
gmake[1]: *** [libxfs] Error 2
make: *** [default] Error 2

Any ideas what's wrong here?

-- steve

