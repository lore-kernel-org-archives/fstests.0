Return-Path: <SRS0=9uao=B2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AADC433E1
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Aug 2020 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9F1206DA
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Aug 2020 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIbM1NPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHPQCu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Aug 2020 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPQCt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Aug 2020 12:02:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE54C061786
        for <fstests@vger.kernel.org>; Sun, 16 Aug 2020 09:02:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g7so5156184plq.1
        for <fstests@vger.kernel.org>; Sun, 16 Aug 2020 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=V57L5MNkTxu46Rktg/ZFo5b00kz8C2BcGR2W2IwjhIw=;
        b=CIbM1NPD08/rSCUXziB5a/dpIaSVht2ol5t+uO5PiT7vxH3Ro4+ST7MiAfcrYQd4CY
         bNHzRtxJ1rcoVQ1PkpQQ6LwhKpVajCTB9JvAILYRSMbMM+SYfDvgD/bvdJVr6q8vBUSO
         pRG/MM3TQO5GqMhYnAp1cGNvo1D6bi90FU91XLc45za6AoKoLqaZB3l0M6CXmgOwzWsi
         wnAc4HrrWKpG+KaZ8EywoEP2fqpKHl9RElgZAawCuDMqnZAKr+mVysnQzEwd3ZK5EMUP
         ZFRi6B+JKIFDEghybc03yNKdwPmi//VAY5mHewSVV9ijvr7lNSnBtFEDdQjhKmCGlSH6
         pfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=V57L5MNkTxu46Rktg/ZFo5b00kz8C2BcGR2W2IwjhIw=;
        b=c8yGqueDGTeceChMKQ0fo2ZDH8HWGWiGkfarRpjHRJ94+SRtOzPs+25x7kUE3nxcs0
         MgHRMYJ2n1abVctWl8TaGHt9gMdypzERWUzhUb3JMFYROd+xXAAfIWlDo2j+x6TiDoV4
         HOIEsQldW9MPOWzUdAZMqNNPqRI/c9dBSgXSTaL3MhB6KMLSCaxt0Nh7sHwXbWvDntrK
         uVyxOnbvJ7eoDkp/JfxsynSgoWD1yh/qK9A8mymX0OjLTXp4HfyXvBSBuO2b+a0s+vfA
         Ydf+Y60lUP2N45CUHyGddNwRBbM2oB9el01tTbjC7/VtX35EC9OWN9m7hWo4fROnto1a
         fMdQ==
X-Gm-Message-State: AOAM533Xlo+nEhVbKc3/3ylBf37DmAREkwz0aP4an6Q5yNGl0vZwkdht
        2Y2nVuGHIlQFLEA+bYbkKXbyEyPsHzM=
X-Google-Smtp-Source: ABdhPJzEkURGkZoa1mTRHjiPhMzzrDbBUMJiky9n5ZYmGSS11BRMt+xhMDU5odnZu3LdGdNuoSf0+g==
X-Received: by 2002:a17:90a:2764:: with SMTP id o91mr9356298pje.113.1597593768412;
        Sun, 16 Aug 2020 09:02:48 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id gj2sm13909918pjb.21.2020.08.16.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 09:02:47 -0700 (PDT)
Message-ID: <5f3958a7.1c69fb81.5753c.ef83@mx.google.com>
Date:   Mon, 17 Aug 2020 00:02:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 8b0e342dac2f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yyY5OToMBUkB"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--yyY5OToMBUkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only adds another two dax related fixes
from Xiao Yang, thanks a lot for all the dax work!

Thanks,
Eryu

The new head of the master branch is commit:

8b0e342dac2f common/rc: Update _exclude_scratch_mount_option() and _require_dm_target() for new dax option

New commits:

Xiao Yang (2):
      [10c189c7e732] common/dmlogwrites: Update _require_log_writes_dax() for new dax option
      [8b0e342dac2f] common/rc: Update _exclude_scratch_mount_option() and _require_dm_target() for new dax option


Code Diffstat:

 common/dmlogwrites | 24 +++++++++++++++++++-----
 common/rc          |  8 ++++++--
 tests/generic/470  |  2 +-
 3 files changed, 26 insertions(+), 8 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--yyY5OToMBUkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl85UqIACgkQJlKqKVyP
52MMcQ//ak3vhmGE+7SHqc4KgR2TTQ4gQXUAhgdpFSmLgEf3bJp+t8pawHW9RAU1
GQcQ+6wtffeBhC/7wJ1zp9bqimc6xEQt6ZqwHsRNIavbnmK+pIahW9UvIOTmM4vX
lyYAUhACinZjRtN0i7ylsfv2BhVdUb7SrkI1t/JC6Kla+00GKY0FdJ7Zt8GhHD1m
B7m11ij9K86/uilJE0kxHR6Mc9oXau2z3jTTGPfpkfJQw5D43g3ISM8W0gYaKPCT
nvKw3oGy7ZFe1MkcyqI6TPlnhzUAwJOM25cCaBCtfEO1eT2Jn7m7Os+HdEmK+xvX
5U+lRf2VHgCrttVZp+iRbDBaQ2CdMqJ30tQ1DTY7fTpnSwTji1+/KMYIAgnHWN9e
Hxk1AQ9tAd2C1fwzxreGEsKQvatSpD25xMbgErCI8+XVUyNZ4ZTho1IUFFPd1bFN
n8kQvapr73l5tmoYmMVLDbhSPFNzNnWQfSNXnd9Cq5n3L/OhDbyngKNxUMUfV5Lt
5Lbqq6Vd5SFvnqIlXd3L/Qkvcq1PR5RRJd7kNKNju4mpDUVq4aeQX93M4wIFjkvG
hLJx1RDiHv8/+7TCxFV9w3osPcmhiU3GYHxbymp6CUcEYtRw7bml6HfZ0/rgNbja
s8BShKavwSF7GcNtjkuu273/+/4ms5ARuSvAWmWEU5kCYnHEKJo=
=LGlW
-----END PGP SIGNATURE-----

--yyY5OToMBUkB--
