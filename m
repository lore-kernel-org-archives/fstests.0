Received: from mail-yw0-f173.google.com ([209.85.161.173]:39295 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933913AbeBMJ6t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Feb 2018 04:58:49 -0500
Received: by mail-yw0-f173.google.com with SMTP id v196so11936087ywc.6
        for <fstests@vger.kernel.org>; Tue, 13 Feb 2018 01:58:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213091203.22909-3-eguan@redhat.com>
References: <20180213091203.22909-1-eguan@redhat.com> <20180213091203.22909-3-eguan@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 Feb 2018 11:58:48 +0200
Message-ID: <CAOQ4uxjqiutLKnYj4FhU9pT516bv-OVqfiwdjVcV5OMq_FNN4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: use _scratch_mount_nocheck where appropriate
 in tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 13, 2018 at 11:12 AM, Eryu Guan <eguan@redhat.com> wrote:
> Also remove redundant status checks of _scratch_mount.

Is there any correlation between tests that need to use _scratch_mount_nocheck
tests which _require_scratch_nocheck that could make some of these annotations
automatic?

Amir.
