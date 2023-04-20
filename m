Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EBC77B73
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjDTQWM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjDTQWI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 12:22:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE6C49D3
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 09:22:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLqN0022541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007713; bh=YWLxJxUxMr6ah8V2OuLflWjxik17j6fmDhvlsYp7qEw=;
        h=From:To:Cc:Subject:Date;
        b=imK8mhJwqpN6xp35m4AnkH/Qa0aq5DQ3qeEnc1hpN+6Pu9xO5N0xq2KR9T/4EgW8h
         5tgaHXtKht6K2Xpzgbz6ftc+LUQJDzGW6CMFvt2mKYG9en6Sgf/jZq8o61gd/xr6R9
         +PpIALkPq6jMKqUN8OwsISCQ7zoJNxSt1wV5v3MJOhIA/DXdsUwJ9OyXp89x7Gfzsj
         BDcbFzPyDDnYn9dlj8CXAjhfkK0QXF4pvg8oH7onLIoAANybTr+RiYC/PmIs2VEJAK
         H/9oa9Gx3oJs7TgNHf0hoo1MONeLUYkBULiF8qFcbNDfDRpnnB67ZzFgTTAD9lWC0L
         t2QewnnliQoZw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2FBE215C3448; Thu, 20 Apr 2023 12:08:40 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] Work around various report.xml compatibility issues
Date:   Thu, 20 Apr 2023 12:08:35 -0400
Message-Id: <20230420160837.1083228-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

While updating {kvm,gce}-xfstests to work with fstests upstream, we
found that Darrick's changes have led to some incompatibilities.  The
most serious one is that it breaks the ability of the junitxml Python
package from being able to parse the report.xml file.  I've worked
around this in my test appliance in the first patch, via the simple
expedient of simply nuking the xmlns attribute from the testcases tag.
However, this may be a compatibility issue that will impact other
fstests users.

The second issue is one which depending on which xunit/Jenkins schema
you believe, the timestamp attribute may possibly not allow the use of
a timezone.  Again, I've worked around it in my test appliance, but it
might be that this will cause compatibility problem with other xunit
parsers.

I know that the report.xml file is strictly not conformat with the
xunit schema already, as discussed in fstests commit b76a6cdb40b5
("report: derive an xml schema for the xunit report").  However, I
believe that in order to allow fstests users to use xunit parsing
packages without having to write their own custom XML parsers, we
should strive to be compatible with as many xunit tools as possible,
whenever it's reasonably possible.

(It's kind of like HTML; no one actually follows the formal spec, so
HTML authoring tools need to be as compatible as possible as with the
most commmonly used browsers, and browsers need to be as flexible as
possible to support HTML files which are "mostly conformant".  :-)

So while this patch series is against fstests-bld, I'm hoping this can
spark a discussion about whether we should make some changes to
fstests to be more compatible in practice with various xunit file
consumers/parsers which might be out there.

Theodore Ts'o (2):
  test-appliance: edit out xmlns from the result.xml file
  test-appliance: support a timestamp specifier which contains a
    timezone

 test-appliance/files/root/runtests.sh                     | 1 +
 .../usr/lib/python3/dist-packages/gen_results_summary.py  | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.31.0

