Received: from imap.thunk.org ([74.207.234.97]:51349 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbcBJCKE convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 9 Feb 2016 21:10:04 -0500
Date: Tue, 9 Feb 2016 21:10:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 00/12] xfstests: fix up various tmpfs failures
Message-ID: <20160210021000.GA26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com
List-ID: <fstests@vger.kernel.org>

Here is the output of "gce-xfstests -c tmpfs -g auto" with these
patches.

						- Ted

CMDLINE: -c tmpfs -g auto
FSTESTVER: e2fsprogs	v1.43-WIP-2015-05-18-64-g2334bd3 (Sat, 5 Sep 2015 22:21:35 -0400)
FSTESTVER: fio		fio-2.6-8-ge6989e1 (Thu, 4 Feb 2016 12:09:48 -0700)
FSTESTVER: quota		7367f5d (Wed, 27 Jan 2016 12:16:25 +0100)
FSTESTVER: xfsprogs	v4.2.0 (Mon, 7 Sep 2015 10:14:31 +1000)
FSTESTVER: xfstests-bld	0f62f62 (Tue, 9 Feb 2016 20:11:45 -0500)
FSTESTVER: xfstests	linux-v3.8-906-ga687f46 (Tue, 9 Feb 2016 20:07:42 -0500)
FSTESTVER: kernel	4.5.0-rc2-ext4-00002-g6df2762 #155 SMP Mon Feb 8 12:32:59 EST 2016 x86_64
FSTESTCFG: "tmpfs"
FSTESTSET: "-g auto"
FSTESTEXC: ""
FSTESTOPT: "aex"
MNTOPTS: ""
CPUS: "2"
MEM: "7477.45"
MEM: 7680 MB (Max capacity)
BEGIN TEST tmpfs: tmpfs Tue Feb  9 20:56:48 EST 2016
MKFS_OPTIONS  -- test:/scratch
MOUNT_OPTIONS -- -o size=1G test:/scratch /test/scratch
Ran: generic/001 generic/002 generic/003 generic/004 generic/005 generic/006 generic/007 generic/011 generic/013 generic/014 generic/015 generic/023 generic/024 generic/025 generic/028 generic/029 generic/030 generic/035 generic/053 generic/067 generic/069 generic/071 generic/074 generic/075 generic/078 generic/080 generic/083 generic/084 generic/086 generic/087 generic/088 generic/089 generic/095 generic/098 generic/100 generic/102 generic/105 generic/109 generic/112 generic/120 generic/123 generic/124 generic/126 generic/127 generic/128 generic/129 generic/131 generic/132 generic/141 generic/169 generic/184 generic/192 generic/193 generic/204 generic/213 generic/215 generic/221 generic/224 generic/228 generic/236 generic/237 generic/241 generic/245 generic/246 generic/247 generic/248 generic/249 generic/256 generic/257 generic/258 generic/274 generic/275 generic/285 generic/286 generic/294 generic/306 generic/307 generic/308 generic/309 generic/310 generic/312 generic/313 !
 generic/314 generic/315 generic/319 generic/320
Failures: generic/080
END TEST: tmpfs Tue Feb  9 21:03:53 EST 2016
