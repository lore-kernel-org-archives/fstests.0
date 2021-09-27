Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF528C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B660B60F4A
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhI0LA2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:00:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhI0LA0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Sep 2021 07:00:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBA661FD3E;
        Mon, 27 Sep 2021 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632740326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nl8Xzt2SphDlzotci2+p+qf9ihyWEqfUFmKZa29oJ44=;
        b=IokdYRwG6nmb3N3ZforvnQmF1uhTZ4JXaLUGPvtl/T3FENMRyLM+2/78OhXX+wiuKCCUkB
        2+uzvY6J5yWDrx07sE8apPFVkSfu7wLqhCHD3BOLew8mUqX9ywYvtEdjy2JyRKBkvz+SIV
        xE5Qzl1IzqEaCAGZwMfgJVd9H92lMJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632740326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nl8Xzt2SphDlzotci2+p+qf9ihyWEqfUFmKZa29oJ44=;
        b=Uw0G7X7mQAjP6BtUkp4hk6bZwRdWvzLaQwNoVeIgHZyA9Sm2XFAMYsx/g56wg7v3f6KE5f
        u8G7kJqQYbY2tYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42A4613A7F;
        Mon, 27 Sep 2021 10:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k5o8DeajUWFmMQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 27 Sep 2021 10:58:46 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 21567620;
        Mon, 27 Sep 2021 10:58:45 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Zorro Lang <zlang@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3 0/2] generic/079 test fails if 'nobody' and 'daemon' don't exist
Date:   Mon, 27 Sep 2021 11:58:41 +0100
Message-Id: <20210927105843.8661-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

Changes since v2:

- Make the 'grep' command more accurate, i.e. make sure user 'myuser'
  exists in /etc/passwd and not 'myuser123'.  Suggested by Zorro Lang.

Changed since v1:

- 'user' variable in _require_user_exists() is now local, as suggested
  by Eric Biggers.

(I've also added Darrick's Reviewed-by tag to the 2nd patch only.)

Original cover-letter:

Test generic/079 currently fails if for some reason the 'nobody' or
'daemon' users don't exist:

*** starting up
add_acl(/mnt/scratch/079/immutable.f) did not set errno == EPERM
add_acl(/mnt/scratch/079/immutable.d) did not set errno == EPERM
add_acl(/mnt/scratch/079/append-only.f) did not set errno == EPERM
add_acl(/mnt/scratch/079/append-only.d) did not set errno == EPERM
testing immutable...FAILED! (2 tests failed)
testing append-only...FAILED! (2 tests failed)
*** cleaning up

The first patch that follows adds a new function _require_user_exists()
that will verify a user exists in the system (and refactors existent
_require_user() to use the new function).

The second patch is the actual test fix.

Luis Henriques (2):
  common/rc: add _require_user_exists() to check if a user exists
  generic/079: make sure users 'nobody' and 'daemon' exist

 common/rc         | 27 ++++++++++++++++++---------
 tests/generic/079 |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

