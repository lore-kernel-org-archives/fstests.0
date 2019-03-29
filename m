Received: from mail-ed1-f53.google.com ([209.85.208.53]:46003 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2P74 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Mar 2019 11:59:56 -0400
Received: by mail-ed1-f53.google.com with SMTP id m16so2431220edd.12
        for <fstests@vger.kernel.org>; Fri, 29 Mar 2019 08:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jMu4RO1mNKmwof8z0rU4Lcr76mPRo04a5sFrs0Saz735ez1w@mail.gmail.com>
 <20190326014337.GI26298@dastard>
In-Reply-To: <20190326014337.GI26298@dastard>
From: Rishabh Dave <ridave@redhat.com>
Date: Fri, 29 Mar 2019 21:29:43 +0530
Message-ID: <CA+jMu4QNB+v-r6KmkUfEh-q5r=m=tCxkLkfrLXA+Ajt12g1SQA@mail.gmail.com>
Subject: Re: testsuite for ACLs
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Reading both replies I feel it's best to rewrite to bash. I'll go
ahead and do that.

On Tue, 26 Mar 2019 at 07:13, Dave Chinner <david@fromorbit.com> wrote:
> So the first question is how many of those 22 tests are already
> covered by ACL tests in fstests? We've got a few tests that cover
> ACLs already:
>
> $ git grep -w acl tests/*/group
> tests/generic/group:026 acl quick auto
> tests/generic/group:053 acl repair auto quick
> tests/generic/group:077 acl attr auto enospc
> tests/generic/group:079 acl attr ioctl metadata auto quick
> tests/generic/group:099 acl auto quick
> tests/generic/group:105 acl auto quick
> tests/generic/group:237 auto quick acl
> tests/generic/group:307 auto quick acl
> tests/generic/group:318 acl attr auto quick
> tests/generic/group:319 acl auto quick
> tests/generic/group:375 auto quick acl
> tests/generic/group:389 auto quick acl
> tests/generic/group:444 auto quick acl
> tests/generic/group:449 auto quick acl enospc
> tests/nfs/group:001 auto quick nfs4_acl acl
> tests/xfs/group:053 attr acl repair quick auto
> tests/xfs/group:067 acl attr auto quick

Is tests/generic/group a list of titles of testcases? If so, I don't
understand them.

I see there are few tests for ACLs in tests/generic/099. I couldn't
find them before since the tests use chacl and I was looking for
setfacl and getfacl. I'll compare my testsuite to tests/generic/099,
create a list of testcases not covered in xfstests-dev and start
rewriting.

- Rishabh
