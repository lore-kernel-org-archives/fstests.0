Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933749AbeBMKJF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Feb 2018 05:09:05 -0500
Date: Tue, 13 Feb 2018 18:09:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] fstests: use _scratch_mount_nocheck where
 appropriate in tests
Message-ID: <20180213100902.GK18267@eguan.usersys.redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com>
 <20180213091203.22909-3-eguan@redhat.com>
 <CAOQ4uxjqiutLKnYj4FhU9pT516bv-OVqfiwdjVcV5OMq_FNN4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqiutLKnYj4FhU9pT516bv-OVqfiwdjVcV5OMq_FNN4w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 13, 2018 at 11:58:48AM +0200, Amir Goldstein wrote:
> On Tue, Feb 13, 2018 at 11:12 AM, Eryu Guan <eguan@redhat.com> wrote:
> > Also remove redundant status checks of _scratch_mount.
> 
> Is there any correlation between tests that need to use _scratch_mount_nocheck
> tests which _require_scratch_nocheck that could make some of these annotations
> automatic?

No, they have totally different meanings. _require_scratch_nocheck means
don't do filesystem check after test, and _scratch_mount_nocheck means
don't check mount status.

Perhaps it's just badly named, I can follow Andreas's suggestion to name
it as _try_scratch_mount or similar names.

Thanks,
Eryu
