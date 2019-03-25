Received: from mail-ed1-f43.google.com ([209.85.208.43]:34401 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfCYNSb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 09:18:31 -0400
Received: by mail-ed1-f43.google.com with SMTP id x14so4845469eds.1
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2019 06:18:30 -0700 (PDT)
MIME-Version: 1.0
From: Rishabh Dave <ridave@redhat.com>
Date: Mon, 25 Mar 2019 18:48:18 +0530
Message-ID: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
Subject: testsuite for ACLs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

I've been writing a testsuite for ACLs for CephFS[1] for some time.
Since the testcases are written from a generic POV, reviewers asked me
to try and get these tests merged with xfstests-dev so that it could
benefit other projects as well.

So far, I've got around 22 testcases. To give a brief summary, the
testsuite has 5 categories of tests: tests for nondefault nonmask
ACLs[2], for nondefault mask ACLs[3], for default nonmask ACLs[4], for
default mask ACLs[5] and, finally, the rest of testcases that don't
fall into previous categories[6] (e.g. testing effect of '-k' and '-b'
option of setfacl). The second last category is neither complete nor
tested, but that shouldn't be a hurdle.

One important issue to address is that my testsuite is written in
Python and xfstests-dev doesn't have any tests in Python. Although I
don't see any guidelines in the repository instructing to not to use
anything other than bash (and since I've never contributed to
xfstest-dev), I think it's best to ask this explicitly: is sending a
patch for tests in Python acceptable for xfstests-dev?

- Rishabh

[1] https://github.com/ceph/ceph/pull/26477
[2] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L270
[3] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L391
[4] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L457
[5] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L549
[6] https://github.com/rishabh-d-dave/ceph/blob/enable-acls-by-default/qa/tasks/cephfs/test_acls.py#L609
