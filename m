Received: from mail-pl1-f194.google.com ([209.85.214.194]:39152 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDUPhT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Apr 2019 11:37:19 -0400
Date: Sun, 21 Apr 2019 23:37:05 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] btrfs: test send with deduplication running concurrently
Message-ID: <20190421153705.GD22372@desktop>
References: <20190415083121.2338-1-fdmanana@kernel.org>
 <CAL3q7H6j_TM+J9o9hc=oxDO+pFzQmur5ignSA3xgiUN4LoZx8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6j_TM+J9o9hc=oxDO+pFzQmur5ignSA3xgiUN4LoZx8Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Apr 20, 2019 at 02:14:25PM +0000, Filipe Manana wrote:
> On Mon, Apr 15, 2019 at 9:32 AM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Stress send running in parallel with deduplication against files that
> > belong to the snapshots used by send. The goal is to hit assertion failures
> > and BUG_ONs when send is running, or send finding an inconsistent snapshot
> > that leads to a failure (reported in dmesg/syslog) and results in an EIO
> > error returned to user space. The test needs big trees (snapshots) with
> > large differences between the parent and send snapshots in order to hit
> > such issues with a good probability.
> >
> > This currently fails in btrfs, and there is a patch for the linux kernel
> > that fixes it and is titled:
> >
> >   "Btrfs: fix race between send and deduplication that lead to failures
> >    and crashes"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Eryu, can you please skip this patch for now? I want to do a v2,
> likely next week, which tests a few more things.
> Thanks.

Sure, thanks for the heads-up!

Eryu
