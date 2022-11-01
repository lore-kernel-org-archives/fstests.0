Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF41C433FE
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Nov 2022 03:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKADsW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKADsU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2022 23:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CB117E23
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 20:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB556153A
        for <fstests@vger.kernel.org>; Tue,  1 Nov 2022 03:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D649C433D6;
        Tue,  1 Nov 2022 03:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667274494;
        bh=F9RChGtVKwISr4LCVSZQyNV7gs3nBlALqPMVQuiUHBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnkhtoZjD1x+AeSyWlw5JsRNAOwoJnWuGjC6Okga1tH1QedEujlqEiEzRuMtYQdQd
         vIHrPw+9N6MGT6v4x8x8pnIEURnkjupkAAYUonOve5jzgt18msLq7bSdLGkE6EuFPY
         usfr/EyCOAih80kW2lUhxPgZvFJKbHpNYtyrGk2rRB9mJw/qPk3PsTPM3fIjrxWgav
         EDQ8OZ3UbBxYTHxKwWHNicbrAVR+q/ibnYqDsbOSzSCkF0qTRPLZKvjfwfAmZ7zvN5
         1AG1whhHHpX/Y7XEx4LJs1EOHxI2OfeicOG4h803fvebmf5yWjnY4Tur+Xa2Sv32H7
         aXt/P42MzTd3w==
Date:   Mon, 31 Oct 2022 20:48:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Message-ID: <Y2CW/n8R4xBklb3x@magnolia>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com>
 <Y1YP7ehSZUdVS4/J@magnolia>
 <ddc1978f-686e-de66-71bf-b39dbafc2a9d@fujitsu.com>
 <OS3PR01MB94990061DFD4223EC681B0AF83349@OS3PR01MB9499.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB94990061DFD4223EC681B0AF83349@OS3PR01MB9499.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 30, 2022 at 07:30:31AM +0000, yangx.jy@fujitsu.com wrote:
> Hi Darrick,
> 
> Ping, is there any feedback on the patch?
> 
> Best Regards,
> Xiao Yang
> 
> -----Original Message-----
> From: Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com> 
> Sent: 2022年10月24日 15:16
> To: Darrick J. Wong <djwong@kernel.org>
> Cc: zlang@redhat.com; fstests@vger.kernel.org; bfoster@redhat.com
> Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with blkdiscard -z
> 
> On 2022/10/24 12:09, Darrick J. Wong wrote:
> > On Sun, Oct 23, 2022 at 06:48:13AM +0000,yangx.jy@fujitsu.com  wrote:
> >> generic/470 was original designed to verify mmap(MAP_SYNC) which is 
> >> only vaild to the DAX capable device(e.g. PMEM). Thin volume[1] was 
> >> introduced to fix the inconsistent filesystem issue[2] but it make 
> >> the test become not run because it doesn't support DAX. As Darrick 
> >> mentioned[3], discarding the entire mapped range of scartch device 
> >> can fix the issue as well, so I try to use blkdiscard -z instead.
> > That might be ok for the*other*  dm-logwrites tests, but isn't the 
> > fundamental problem here (generic/470, specifically) that device 
> > mapper cannot run on top of pmem?
> 
> Hi Darrick,
> 
> With the change，I didn't find any failure when running generic/470 in loops.
> --------------------------------------------------------------
> [root@fedora35 xfstests-dev]# ./check generic/470
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 fedora35 6.1.0-rc1+ #37 SMP 
> PREEMPT_DYNAMIC Fri Oct 21 19:04:57 CST 2022 MKFS_OPTIONS  -- -f /dev/pmem0 MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/pmem0 /mnt/scratch
> 
> generic/470 6s
> Ran: generic/470
> Passed all 1 tests
> --------------------------------------------------------------
> Both dm-log-writes and PMEM support DAX so it's fine to verify
> mmap(MAP_SYNC) with the dm-log-writes device on top of PMEM.
> 
> Did I miss something? Why do you think there is a fundamental problem here?

Nope, you're right.  fsdax works fine, at least on these simple(r)
device mapper devices:

$ git grep -c dax drivers/md/
drivers/md/dm-core.h:1
drivers/md/dm-linear.c:19
drivers/md/dm-log-writes.c:19
drivers/md/dm-stripe.c:19
drivers/md/dm-table.c:18
drivers/md/dm-target.c:4
drivers/md/dm-writecache.c:7
drivers/md/dm.c:36

(Most notably, dm-logwrites :))

I'll go look at the test in the morning.

--D

> Best Regards,
> Xiao Yang
> 
> > 
> > --D
> > 
