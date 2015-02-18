Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:46119 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbBRLEz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 Feb 2015 06:04:55 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so386923wgh.8
        for <fstests@vger.kernel.org>; Wed, 18 Feb 2015 03:04:54 -0800 (PST)
Date: Wed, 18 Feb 2015 12:04:51 +0100
From: Dongsu Park <dongsu.park@profitbricks.com>
Subject: Re: Test xfs/106 failure
Message-ID: <20150218110451.GB2631@posteo.de>
References: <20150217163149.GA1824@quack.suse.cz>
 <20150218102126.GA2631@posteo.de>
 <20150218104155.GC4614@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150218104155.GC4614@quack.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 18.02.2015 11:41, Jan Kara wrote:
> On Wed 18-02-15 11:21:26, Dongsu Park wrote:
> > That reminds me of a bug that has occurred every time when I run xfs/106.
> > The crash happens only with CONFIG_XFS_DEBUG enabled.
> > When I first discovered that, I disabled CONFIG_XFS_DEBUG as a workaround.
> > As far as I remember, it started to occur since 3.19-rc?, and the first
> > bad commit was 14bf61ffe6ac ("quota: Switch ->get_dqblk() and ->set_dqblk()
> > to use bytes as space units"). I just tested it again with
> > linux-block.git/for-3.20/drivers. The bug is still there.
>   Yesterday, I've sent a patch which should fix this
> (http://www.spinics.net/lists/stable/msg79800.html). Above commit just
> uncovered a long standing problem in XFS quota implementation...

Aha, great. With that patch applied, the crash is gone. :-)

Thanks,
Dongsu

> 								Honza
> 
> > ====
> > XFS (vdc1): Quotacheck: Done.
> > XFS: Assertion failed: dst->d_spc_timer != 0, file: fs/xfs/xfs_qm_syscalls.c, line: 893
> > ------------[ cut here ]------------
> > kernel BUG at fs/xfs/xfs_message.c:106!
> > invalid opcode: 0000 [#1] SMP 
> > CPU: 0 PID: 4031 Comm: xfs_quota Tainted: G        W      3.19.0-rc7+ #174
> > RIP: 0010:[<ffffffff813a9202>]  [<ffffffff813a9202>] assfail+0x22/0x30
> > Call Trace:
> >  [<ffffffff813d4de4>] xfs_qm_scall_getquota+0x284/0x330
> >  [<ffffffff813dce08>] xfs_fs_get_dqblk+0x68/0x90
> >  [<ffffffff81292b6f>] quota_getxquota+0x6f/0x200
> >  [<ffffffff812931cc>] SyS_quotactl+0x4cc/0x740
> >  [<ffffffff817f4cf7>] ? sysret_check+0x1b/0x56
> >  [<ffffffff8151aa1b>] ? trace_hardirqs_on_thunk+0x3a/0x3f
> >  [<ffffffff817f4cd2>] system_call_fastpath+0x12/0x17
> > RIP [<ffffffff813a9202>] assfail+0x22/0x30
> >  RSP <ffff88007a9e7d08>
> > ---[ end trace 308df0cc6a9ba1d0 ]---
> > ====
> > 
> > > 								Honza
> > > 
> > > -- 
> > > Jan Kara <jack@suse.cz>
> > > SUSE Labs, CR
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> Jan Kara <jack@suse.cz>
> SUSE Labs, CR
