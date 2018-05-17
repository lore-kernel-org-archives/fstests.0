Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750859AbeEUWw7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 18:52:59 -0400
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 0/0] cifs: add documentation on how to run xfstest
Date: Thu, 17 May 2018 13:55:52 +1000
Message-Id: <20180517035553.18859-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

List, All,

Please find a patch that adds a basic README file for cifs testing
and some useful configuration templates and exclusion files.

The exclusion files are currently only for SMB3, the dialect where
most crunch/interest is right now, but will later be expanded
to include also earlier dialects.

The purpose of the exclusion files and the reason for having them
in the git tree is to avoid the current situation where all cifs
developers have their own scripts and their own list of tests
ro run or not to run. These are all, of course, not synchronized so
I expect everyone to run slightly different tests.
If we have this in git then we have one canonical list of tests
that are run and also explanations for why some tests are expected
to fail.
In particular the latter would be useful for newcomers as it might
not be immediately obvious why a whole bunch of tests would fail
and if it is expected or not.

