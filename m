Received: from plane.gmane.org ([80.91.229.3]:34263 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105AbcA3BAJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 29 Jan 2016 20:00:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcff-fstests@m.gmane.org>)
	id 1aPJtT-0006YR-P1
	for fstests@vger.kernel.org; Sat, 30 Jan 2016 02:00:04 +0100
Received: from 216.239.45.82 ([216.239.45.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <fstests@vger.kernel.org>; Sat, 30 Jan 2016 02:00:03 +0100
Received: from gwendal by 216.239.45.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <fstests@vger.kernel.org>; Sat, 30 Jan 2016 02:00:03 +0100
From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 3/6] xfsprogs: define and use =?utf-8?b?QlVJTERfQ0M=?= in configure.ac for cross compilation
Date: Sat, 30 Jan 2016 00:58:23 +0000 (UTC)
Message-ID: <loom.20160130T015340-454@post.gmane.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu> <1437913255-7524-4-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Theodore Ts'o <tytso <at> mit.edu> writes:


> -	$(Q) $(CC) $(CFLAGS) -o gen_crc32table $<
> +	$(Q) $(BUILD_CC) $(CFLAGS) -o gen_crc32table $<

Try to cross compile to armv7a, but I hit a compilation failure for 
gen_crc32table.c:
gcc.real: error: unrecognized command line option '-mfpu=neon'
gcc.real: error: unrecognized command line option '-mfloat-abi=hard'

The problem is CFLAGS is set up for the cross compiler (armv7a-cros-linux-
gnueabi-gcc) and some options does not work on the native compiler.

(CFLAGS is " -O2 -O2 -pipe -march=armv7-a -mtune=cortex-a15 -mfpu=neon -
mfloat-abi=hard -g -fno-exceptions -fno-unwind-tables -fno-asynchronous-
unwind-tables")

Looking into defining BUILD_CFLAGS.

Gwendal.



