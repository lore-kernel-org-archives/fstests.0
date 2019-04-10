Received: from mail-qt1-f178.google.com ([209.85.160.178]:39947 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfDJQX7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Apr 2019 12:23:59 -0400
Received: by mail-qt1-f178.google.com with SMTP id x12so3557716qts.7
        for <fstests@vger.kernel.org>; Wed, 10 Apr 2019 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
 <20190326014337.GI26298@dastard> <CA+jMu4QNB+v-r6KmkUfEh-q5r=m=tCxkLkfrLXA+Ajt12g1SQA@mail.gmail.com>
In-Reply-To: <CA+jMu4QNB+v-r6KmkUfEh-q5r=m=tCxkLkfrLXA+Ajt12g1SQA@mail.gmail.com>
From: Rishabh Dave <ridave@redhat.com>
Date: Wed, 10 Apr 2019 21:53:47 +0530
Message-ID: <CA+jMu4TtNT66Ag8S0tYDwTbFf2DM=SvKbneBOCrwEgRdBLakMA@mail.gmail.com>
Subject: Re: testsuite for ACLs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

I went through all the tests in last couple of days. If my
understanding is correct, all the tests, besides the ones in
tests/generic/099, are written for some specific bug. So, the
following comparison of my Python testsuite[1] is with
tests/generic/099.

To begin with, there is a good amount of intersection between both the
testsuite. What can be added to xfstests-dev is as follows -
1. ACL inheritance is being tested only for file owner, file group and
other ACLs[2].  We can add 2 more testscases here for specific users
and groups (i.e cases testing d:u:user:rwx and d:g:group:rwx).
2. Mask ACLs are only being tested for ACLs for specific user[3][4]
and group[5] but not for file owner, file group and other. If I am
right about this, we can add 3 more testcases here.
3. There are no testcases for mask inheritance. If we wish to add
them, we'll have 5 more testcases.
4. And finally I don't see a testcase where we remove only the default
ACLs from a directory. There are testcases that remove all ACLs (i.e.
chacl -B)[6]  and all file access ACLs (i.e. chacl -R)[7]. So, there's
scope for one more testcase here.

Besides, all my Python testcases varied from the ones written in
xfstests-dev in following 2 ways:
1. All 3 permission bits were tested for all the cases.
2. Every testcase would also remove the ACL within the testcase. This
served as test if setfacl -x works for all 4 categories of ACLs.

If these 2 points are not superfluous, I can go ahead modify all the
testcases accordingly.

- Rishabh

[1] https://github.com/ceph/ceph/pull/26477/commits/3d1c11b6990befb278320d3584602aa5d0078985
[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n227
[3] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n188
[4] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n193
[5] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n183
[6] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n254
[7] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/099#n253
