Received: from newman.cs.utexas.edu ([128.83.139.110]:40559 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCEBIS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Mar 2019 20:08:18 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x2518Grd008499
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 4 Mar 2019 19:08:17 -0600
Received: by mail-ot1-f52.google.com with SMTP id e15so5983812otk.6
        for <fstests@vger.kernel.org>; Mon, 04 Mar 2019 17:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard> <20190305010031.GB26298@dastard>
In-Reply-To: <20190305010031.GB26298@dastard>
From: Vijay Chidambaram <vijay@cs.utexas.edu>
Date: Mon, 4 Mar 2019 19:08:05 -0600
Message-ID: <CAHWVdUXMXtvncVQSqO8vdowct+GYE1nENePNvFJFjvoWzSHMcw@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 4, 2019 at 7:00 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 05, 2019 at 11:50:20AM +1100, Dave Chinner wrote:
> > On Mon, Mar 04, 2019 at 05:04:23PM +0200, Amir Goldstein wrote:
> > > On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
> > > >
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that if we truncate a file to reduce its size, rename it and then
> > > > fsync it, after a power failure the file has a correct size and name.
> > > >
> > >
> > > I am not sure that ext4/xfs semantics guaranty anything about
> > > persisting file name after fsync of file?...
> >
> > They do.  It's that pesky "strictly ordered metadata" thing I keep
> > having to explain to people...
>
> https://marc.info/?l=fstests&m=155010885626284&w=2

With reference to that previous conversation, Jayashree and I are
planning to submit a patch adding something like
Documentation/filesystems/crash-recovery.txt to document crash
guarantees and strictly ordered metadata semantics soon! So hopefully
there will be in-kernel documentation we can point folks to soon.
