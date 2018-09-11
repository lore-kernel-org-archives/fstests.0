Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbeIKKZx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Sep 2018 06:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AACFA8011309
        for <fstests@vger.kernel.org>; Tue, 11 Sep 2018 05:28:20 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-85.bne.redhat.com [10.64.54.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CBEC2166BA3
        for <fstests@vger.kernel.org>; Tue, 11 Sep 2018 05:28:19 +0000 (UTC)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 0/1] cloner: add support for clone_file_range for cifs
Date: Tue, 11 Sep 2018 15:28:05 +1000
Message-Id: <20180911052806.1302-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is a trivial patch that adds support for copy_file_range for cifs.
This uses the copy_file_range interface which cifs.ko supports.

Note that cloner.c uses an ioctl() for copying an entire file. This is
an older interface from before cifs.ko added proper copy_file_range
support but both interfaces eventually end up in the same codepaths
and use the same SMB2 commands on the wire.
Could argue that we could/should use copy_file_range() for the whole file
case as well but there is no harm leaving it as-is using the older interface.
