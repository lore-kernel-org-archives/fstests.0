Received: from mail-yw0-f193.google.com ([209.85.161.193]:43025 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeEONuF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 May 2018 09:50:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgEF7cHmb05AxFJyHaV1zWC+Zk08dDNPepfhZ0Foz31Hg@mail.gmail.com>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
 <1526276991-23897-2-git-send-email-amir73il@gmail.com> <20180514230130.GD23861@dastard>
 <CAOQ4uxgEF7cHmb05AxFJyHaV1zWC+Zk08dDNPepfhZ0Foz31Hg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 16:50:04 +0300
Message-ID: <CAOQ4uxikFp-GsuhmPHud4QtKrSdojBNAnDB6yOfrG-11GU_jRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] generic/459: use xfs_freeze instead of fsfreeze
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, May 15, 2018 at 8:25 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, May 15, 2018 at 2:01 AM, Dave Chinner <david@fromorbit.com> wrote:
>> On Mon, May 14, 2018 at 08:49:49AM +0300, Amir Goldstein wrote:
>>> This is what all other tests use as well as _require_freeze
>>>
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>> ---
[...]
>>
>> Shouldn't these all be converted to XFS_FREEZE_PROG w/ a setup call
>> to export XFS_FREEZE_PROG="`set_prog_path xfs_freeze`"?
>>
>
> Yeh, I suppose I can take this one as part of the "freeze" cleanup.
>

I looked again and xfs_freeze pattern repeats itself quite often with
other xfs_* progs, so I guess I'll leave that cleanup for another time...

Thanks,
Amir.

$ git grep -v '^[[:space:]]*[#;]' tests/*/???| grep -v echo > all
$ (cd /usr/sbin; ls xfs_*) > xfsprogs
$ for p in `cat xfsprogs`; do echo $p; grep -w $p all | wc -l; done
xfs_admin
1
xfs_bmap
24
xfs_copy
9
xfs_db
35
xfs_estimate
0
xfs_freeze
17
xfs_fsr
15
xfs_growfs
3
xfs_info
31
xfs_io
17
xfs_logprint
0
xfs_mdrestore
7
xfs_metadump
1
xfs_mkfile
1
xfs_ncheck
0
xfs_quota
43
xfs_rtcp
0
xfs_spaceman
0
