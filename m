Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC3C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiBIW1A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:27:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7950E00E5B7
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JqeM84fDSFtXmifriZ2nTOJQKSW34xBO5T4YjpCiOAw=; b=PKXcVLngcjRi2QCKOh8fS/OWfG
        fadujW3wx3ZEYhHbinbxB4rhUwgQnL+PNh6yhsIy6BWOtm2JYo0DSVF6/U1wi1HKeL+qeNaA0uQcV
        GYEljiilgxbPGCa4a+oq7uTW1/liKa7McJJ6VkzwMWHCCMfC0aXWW8K65+uNyVTccVvNBSI4Yb2Vu
        SmOhCZ6KoHT7dqZYQ2qnNG6nwGKHAn5h0QkjD3EfY3381v/H+mx1QwvxSGx1b5Rsvr0jLgiDFZBkE
        XwpMc+FyR+JwlpyatlOKWetEmVnYH3kcUbp5POw7+u12f0aInW4oPtqicNQu7iP26tnpB9zzg98WX
        87CQhGNA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5Z-GJ; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/25] dbench: fix compile warnings and update a bit
Date:   Wed,  9 Feb 2022 14:25:45 -0800
Message-Id: <20220209222610.438470-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some form of OCD kicked and so this fixes all compile errors on
dbench. It also fixes compiling with smbclient as detection of the
library wasn't working anymore. This also modernizes the default
build output to be a bit more quiet and only if you issue V=1 do
you get the details behind what is being built. In case this never
ends up on samba's git tree I've put mine up on github [0].

Well, hopefully Debian starts carrying dbench again soon.

[0] https://github.com/mcgrof/dbench

Luis Chamberlain (25):
  dbench: simplify open_loadfile() as check_loadfile_ok()
  child: fix usage of gzFile and gzopen()
  dbench: remove unused double t value
  child: fix data type comparison on child_run
  Makefile.in: disable unused warning for rpc generated code
  configure.ac: run autoupdate
  dbench: update use of time.h or sys/time.h
  config.h.in: run autoconf
  snprintf: specify safe fallthrough on switches
  nfsio.c: include dbench.h before nfs.h
  nfsio: remove unused status variable
  child: be expicit about string truncation goal
  child: do not overlap on memcpy()
  dbench.h: use bits/types.h instead of defining uint32
  sockio.c: use uint32_t
  libnfs.c: fix a few simple compile warnings
  libnfs: fix compilation warning for inet_tons
  libnfs.c: fix sign conflict compile warning
  Makefile.in:
  linux_scsi.c: fix redeclaration of _GNU_SOURCE
  Makefile.in: modernize build output with V=1 or V=0
  Makefile.in: declare datarootdir
  configure.ac: fix smbclient detection
  libiscsi: fix compile warning on data types
  smb: fix compilation and disable warning on deprecated-declarations

 Makefile.in  | 131 +++++++++++++++++++++++++++++++--------------------
 child.c      |  16 +++++--
 config.h.in  |  19 --------
 configure.ac |  41 +++++++---------
 dbench.c     |  27 ++++++-----
 dbench.h     |  16 ++++++-
 libiscsi.c   |   2 +-
 libnfs.c     |  15 +++---
 linux_scsi.c |   4 --
 nfsio.c      |   3 +-
 snprintf.c   |   3 ++
 sockio.c     |   2 +-
 12 files changed, 153 insertions(+), 126 deletions(-)

-- 
2.34.1

