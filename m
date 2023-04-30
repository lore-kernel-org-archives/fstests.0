Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5BC77B73
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Apr 2023 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjD3Q3z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Apr 2023 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3Q3y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Apr 2023 12:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE01BC3
        for <fstests@vger.kernel.org>; Sun, 30 Apr 2023 09:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5DA60BB5
        for <fstests@vger.kernel.org>; Sun, 30 Apr 2023 16:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EFDC433EF;
        Sun, 30 Apr 2023 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682872192;
        bh=rPKtO8Xr3le//Wzovls8+9KDvdS8nt4jzPnOwGflRhk=;
        h=Date:From:To:Subject:From;
        b=QMvxhGRm3/YidI/xVqs1+n4+cI656/KMPlWvkGJn9VS24ZC+y8uJKdT7ILVZ7/vId
         BcOXanYoI3coofiqLbNk0W1nMfZ0R9E7HPV7I0bkTLp+qrUsUTSbJ5YHsMzdIEdHqv
         itSRLo0JcoX7olNGbfNXEbaijI3eqNk1GnpkByTnTJlyg5lEtaERTArKQz4Po35Oou
         2pfgrfRZN58EWTUyc2cqqzQF9tG1wxNKkizLEba1OjHedePKXTCkaW02NVLFUdLbme
         kvW9K4qQ8B3MLNO/WnfiyZO8KyyAWsCstYz2c/dI2e5hX7Rxp8vS6kCz0PQwZ78ZZ7
         qh9NAC4O32byQ==
Date:   Mon, 1 May 2023 00:29:46 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.04.09 onto master branch
Message-ID: <20230430162946.ydjakc7nt64qyyi3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.04.09 version.

Thanks,
Zorro

The new head of the master branch is commit:

3a56e665384e fstests/MAINTAINERS: add a co-maintainer for btrfs testing part

New commits:

Anthony Iliopoulos (1):
      [c91ff78d21f6] common: switch _get_{available,total}_space accounting to units of single bytes

Darrick J. Wong (6):
      [5858995b1f4e] generic/{251,260}: compute maximum fitrim offset
      [7d5d3f77154e] xfs/242: fix _filter_bmap for xfs_io bmap that does rt file properly
      [ccf4d08d12e3] common/report: fix typo in FSSTRESS_AVOID
      [a8e4eb5f7d2f] common/populate: fix btree-format xattr creation on xfs
      [c7db4edfe967] populate: create fewer subdirs when constructing directories
      [8d69dc3757ce] populate: create fewer holes in directories and xattrs

Zorro Lang (5):
      [2a442d6a587d] fstests: add MAINTAINERS and get_maintainer.pl files
      [d349bd4a0dff] tools/get_maintainer.pl: remove penguin chiefs
      [c72cc820eb60] fstests/MAINTAINERS: add supported mailing list
      [3a49eed5c634] fstests/MAINTAINERS: add some specific reviewers
      [3a56e665384e] fstests/MAINTAINERS: add a co-maintainer for btrfs testing part


Code Diffstat:

 MAINTAINERS             |  200 ++++
 common/populate         |   63 +-
 common/punch            |    8 +
 common/rc               |   23 +-
 common/report           |    2 +-
 common/xfs              |    8 +
 src/popdir.pl           |   15 +-
 tests/generic/251       |    2 +-
 tests/generic/260       |    2 +-
 tools/get_maintainer.pl | 2573 +++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2876 insertions(+), 20 deletions(-)
--
Zorro Lang
zlang@kernel.org
