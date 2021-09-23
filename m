Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47736C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AAE61211
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Sep 2021 10:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhIWKm7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:42:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhIWKm7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Sep 2021 06:42:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 286301FFA1;
        Thu, 23 Sep 2021 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632393687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dGB8VyJXBxGYzJysknMqH6lHe2E2CiQlMyfRtlgPE88=;
        b=jzSj/GIMpfHZeQV56wSx/ROm/miyANyJRdrcnIAJ4IhHf5THJ+I2jMoOJfY2at6Ih12FvN
        k0wmGLCdjH9jLJ57jXC4MaNuxvsoc8/ZVpidYalUb73FZM0Sjfkmtg+EWWS99HnJexh/kN
        e3C9rfmbdBXue+8AuDF78CGKLHOMVmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632393687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dGB8VyJXBxGYzJysknMqH6lHe2E2CiQlMyfRtlgPE88=;
        b=Udeypqzc3HXjEShR5lKw2vcAo9oTIQyEcGTqi60PQuurFk6eUI+E4PRRsQ/K9nSvvtomNj
        umaKr5l+VdpSWBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D04B613DCD;
        Thu, 23 Sep 2021 10:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SJfiL9ZZTGFgZwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 23 Sep 2021 10:41:26 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id b1aa4a41;
        Thu, 23 Sep 2021 10:41:26 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, Luis Chamberlain <mcgrof@kernel.org>,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH 0/2] generic/079 test fails if 'nobody' and 'daemon' don't exist
Date:   Thu, 23 Sep 2021 11:41:21 +0100
Message-Id: <20210923104123.29878-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

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

