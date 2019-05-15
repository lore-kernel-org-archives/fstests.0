Received: from newman.cs.utexas.edu ([128.83.139.110]:37381 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfEOPH1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 May 2019 11:07:27 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x4FF7PmV023256
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 15 May 2019 10:07:25 -0500
Received: by mail-ot1-f43.google.com with SMTP id g18so277364otj.11
        for <fstests@vger.kernel.org>; Wed, 15 May 2019 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190515150221.16647-1-fdmanana@kernel.org>
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
From: Vijay Chidambaram <vijay@cs.utexas.edu>
Date: Wed, 15 May 2019 10:07:14 -0500
Message-ID: <CAHWVdUWQXDf0fDTg=43ySNEbTEqPh1ue6ZujsBX-wTsmLQGz3A@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 15, 2019 at 10:02 AM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Run fsstress, fsync every file and directory, simulate a power failure and
> then verify the all files and directories exist, with the same data and
> metadata they had before the power failure.

I'm happy to see this sort of crash testing be merged into the Linux
kernel! I think something like this being run after every
merge/nightly build will make file systems significantly more robust
to crash-recovery bugs.
