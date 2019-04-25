Received: from mail-pg1-f178.google.com ([209.85.215.178]:43298 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfDYUjx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 16:39:53 -0400
Received: by mail-pg1-f178.google.com with SMTP id z9so410368pgu.10
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 13:39:53 -0700 (PDT)
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 25 Apr 2019 13:39:40 -0700
Message-ID: <CAH2r5mu9WFqz=15ENbt27wW+qP+XaJgyGs-B8Yq4_sn931vxnA@mail.gmail.com>
Subject: generic: test statx attribute_mask setting
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

I noticed that the patch "generic: test statx attribute_mask setting"
seems to cause a failure on xfstest 532.  I am trying with current
xfsprogs and xfstests from git.kernel.org git trees for those.  The
output is:

(generic/532    [not run] xfs_io statx command does not support attributes_mask)

due to this line:

0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 35) get_attributes_mask() {
0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 36)
$XFS_IO_PROG -r -c "statx -r" $1 | grep 'stat.attributes_mask =' | cut
-d ' ' -f 3

But attributes_mask is not returned by current xfsprogs (instead it
appears to be "mask" not "attributes_mask").   If you grep xfsprogs
for "attributes_mask" - there are no hits.

Is this a typo in line 36 of tests/generic/532 where it is searching
for "stat.attributes_mask" not "stat.mask"?

-- 
Thanks,

Steve
