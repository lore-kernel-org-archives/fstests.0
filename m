Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1895EC3403F
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA3C208C4
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBROfv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:35:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55043 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727313AbgBROfs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 09:35:48 -0500
Received: from callcc.thunk.org ([12.23.74.26])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01IEZY9b014015
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 09:35:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 958DA4211EF; Tue, 18 Feb 2020 09:35:33 -0500 (EST)
Date:   Tue, 18 Feb 2020 09:35:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200218143533.GD12604@mit.edu>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213170853.GA311476@mit.edu>
 <1c81c16b-6e31-74cb-0b88-46663fad500d@cn.fujitsu.com>
 <20200214140541.GA434121@mit.edu>
 <7adf16bf-d527-1c25-1a24-b4d5e4d757c4@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7adf16bf-d527-1c25-1a24-b4d5e4d757c4@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 18, 2020 at 11:44:24AM +0800, Yang Xu wrote:
> 
> 
> on 2020/02/14 22:05, Theodore Y. Ts'o wrote:
> > On Fri, Feb 14, 2020 at 09:14:33AM +0800, Yang Xu wrote:
> > > > 
> > > > So were you able to reproduce this on a 5.6.0-rc1 kernel or not?
> > > No. I don't reproduce it on 5.6.0-rc1 kernel, but  5.6.0-rc1 kernel hang on
> > > my KVM machine when run generic/269.
> > 
> > I'm not able to reproduce the 5.6.0-rc1 hang using kvm-xfstests[1].
> > Neither has any other ext4 developers, which is why it might be useful
> > to see if there's something unique in your .config for 5.6.0-rc1.
> > Could you send us the .config you were using?
> > 
> Sorry for the late reply.
> 
> my 5.6.0-rc1 config as attach.

Unfortunately, I just tried using your config with kvm-xfstests, and
it passed without problems.  Did you say this was a reliable
reproducer on your system?

% kvm-xfstests -c 4k generic/269
KERNEL:    kernel 5.6.0-rc2-xfstests #1492 SMP Mon Feb 17 23:22:40 EST 2020 x86_64
CPUS:      2
MEM:       1966.03

ext4/4k: 1 tests, 43 seconds
  generic/269  Pass     42s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 42s

FSTESTVER: blktests 9e02419 (Thu, 19 Dec 2019 14:45:55 -0800)
FSTESTVER: e2fsprogs v1.45.4-15-g4b4f7b35 (Wed, 9 Oct 2019 20:25:01 -0400)
FSTESTVER: fio  fio-3.17 (Mon, 16 Dec 2019 15:48:43 -0700)
FSTESTVER: fsverity v1.0 (Wed, 6 Nov 2019 10:35:02 -0800)
FSTESTVER: ima-evm-utils v1.2 (Fri, 26 Jul 2019 07:42:17 -0400)
FSTESTVER: nvme-cli v1.9-159-g18119bc (Thu, 26 Dec 2019 11:04:01 -0700)
FSTESTVER: quota  9a001cc (Tue, 5 Nov 2019 16:12:59 +0100)
FSTESTVER: util-linux v2.35-19-g95afec771 (Fri, 24 Jan 2020 12:25:35 -0500)
FSTESTVER: xfsprogs v5.4.0 (Fri, 20 Dec 2019 16:47:12 -0500)
FSTESTVER: xfstests linux-v3.8-2652-g002e349c (Fri, 24 Jan 2020 00:49:40 -0500)
FSTESTVER: xfstests-bld 6f10355 (Fri, 24 Jan 2020 12:36:30 -0500)
FSTESTCFG: 4k
FSTESTSET: generic/269
FSTESTOPT: aex

This was run on a Debian testing system, with kvm version:

QEMU emulator version 4.2.0 (Debian 1:4.2-3)

What about hardware details of your system?  How many CPU's, memory,
etc.?  And what sort of storage device are you using for kvm?  (I'm
using virtio-scsi backed by LVM volumes for the scratch and test
partitions.)

						- Ted
