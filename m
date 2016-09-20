Received: from mx1.redhat.com ([209.132.183.28]:36102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbcITWOq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Sep 2016 18:14:46 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 306114E4EF
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2016 22:14:46 +0000 (UTC)
Received: from Liberator.example.com (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8KMEj0o024961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2016 18:14:46 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/3] move xfs non-project quota tests to generic
Message-ID: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
Date: Tue, 20 Sep 2016 17:14:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Now that bleeding edge xfs_quota can support basic operations
on non-xfs filesystems, move some xfs-specific quota tests into
generic/

Project related tests will come later after a bit more cleanup.

Several xfs quota tests can't be generic, as they depend on
various xfs-specific bits like xfs_db or bulkstat.
