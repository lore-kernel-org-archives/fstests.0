Return-Path: <SRS0=+iS3=2F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E36C43603
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F720726
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4rKylSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfLOQuG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:50:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46160 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfLOQuF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Dec 2019 11:50:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id y14so4263305pfm.13
        for <fstests@vger.kernel.org>; Sun, 15 Dec 2019 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=Ldx5HKDO+K18aAlbhl7QPVpSxwIKAG7L8/RdIblXYww=;
        b=I4rKylStqQoKD0IBDNe2JRkK6LZpE8JsY2KVx0SGJrSvYncxhFZCfJRNXZWpgGrc0i
         /33WreJ/EzZpJVY1KU6Wp0BVESrbYMbwfS47iX6JM4aZY2bkVBXTbe4cbv4oQHlmpRom
         r81Jf2/4WTtYhV+sZVoqPrYr7LffWG2+sG2KUQRKuu3cQTC0FPrnZZAZppZQCb3NcBpn
         nqzgSjwd+NRSVj+oNjr2x43unIakFMuof9e9b1LK3TetDLaOKr2sf8FHZV+Z7jj0tsrM
         zRCEDdbwcIbPV6QiVxizPIrBKbwog6zGvdNObONluogXqGYjYluaf51coh7mitasCz5f
         AdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=Ldx5HKDO+K18aAlbhl7QPVpSxwIKAG7L8/RdIblXYww=;
        b=TLwNDgjhbGMowiAXv5T74QkH3rE2evX1sTExv9CpQPQpygkNVZ3ARVA/xCpd6hkdTh
         d121sDUpBeoh53KTI8Jk6bSB4EwA2A+HviO7oaDePifWgTCgaFJCrUUH1w6YDScuFOw+
         oNTYLuE35QtGO+EyiP2P9YuIMASKQ/GUq5bq7HlStezlH6xnAVNnULq67E9g1sS2mA75
         c7reYrSVg7KALQFBkTpw0AEf7tOnnF387nbvupEiw6iwstF5uXfojPKdNFGW9SXyzVoJ
         T5Ax+WZRNHNSbWOcJmlvcG8jNezwbh8A/zgJ79uTC9RX+YFYE++VJizw5HCPhSoUUnCc
         QicA==
X-Gm-Message-State: APjAAAVRdsIppz57R7uZ8ht5ICAFQwOWOSr48TRT6GD7Uc9h2y3fzXoq
        hRLkWzuFJHALP1pzuYr4d9AHjbv+
X-Google-Smtp-Source: APXvYqzSLoQJOjKiyxC21jb1RZ3ZqNnAxR9nkppis+EUwMS5Uw0oBoZTs4eRZgNwQtUy6TfKitwwJQ==
X-Received: by 2002:a62:174b:: with SMTP id 72mr11637946pfx.185.1576428605040;
        Sun, 15 Dec 2019 08:50:05 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id e27sm19417835pfj.129.2019.12.15.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:50:04 -0800 (PST)
Message-ID: <5df6643c.1c69fb81.ee70a.756a@mx.google.com>
Date:   Mon, 16 Dec 2019 00:49:59 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to db6de9645d19
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6Th29Dm9mz74"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--6Th29Dm9mz74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. My apologies that I didn't have much time reviewing
patches recently, and didn't find the regression introduced by commit
37520a314bd4 in review.. So I only picked up reviewed bug-fixes and reverted
37520a314bd4 in this update.

Thanks,
Eryu

The new head of the master branch is commit:

db6de9645d19 common/rc: fix device size parser

New commits:

Dennis Zhou (1):
      [db6de9645d19] common/rc: fix device size parser

Eryu Guan (1):
      [b25cac5542e9] Revert "fstests: Don't use gawk's strtonum"

Johannes Thumshirn (1):
      [32bf2fee7226] btrfs/187: require 8GB scratch dev

Luis Henriques (1):
      [5ddc9604bd2d] generic/590: add _require_xfs_io_command "falloc"


Code Diffstat:

 common/filter     | 22 ++++++++++------------
 common/rc         |  2 +-
 tests/btrfs/187   |  3 +++
 tests/generic/386 |  2 +-
 tests/generic/590 |  1 +
 tests/xfs/009     | 10 +++++-----
 6 files changed, 21 insertions(+), 19 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--6Th29Dm9mz74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl32Y3kACgkQJlKqKVyP
52MYZw//bRQmzu8DNdnUUf2lUXU4WWWqevrLj1BUZ8zb2mge55/KRQEKrJ7296ZU
VC95/4//Sb+2QOJg2QYqeot0hct0Bx688B6vBNW6OL6NmMCPl2wc07dtjwVrlXNy
N4AYGG4MQh+WeLHKMXJb8wREKkqmFP6tSQ+jzMp2u8qSkIgM2WF1/KDbgMTFqKBz
LoM8vI6kGkPA/VJn46TCDtIyAMfnu7cHmM3sNtVA8ltK5PaXSujPUVdze1hA03rS
PyJmaOxe5Y0uFDIHbL2SFby/Xvy6tJBljKLxVbPGCpumYvWxFFcC1pPc3k+DN+6q
AUXB3i3odikS2UduaTxAOgkOkzeORbm6g7DTYXvq07xUe16Oml045w63q2F4D18L
hE6o/jerJahJrX0osm+X1TLfSIa+y/N0Wqapg/nkri9T44WfrI/ZDCt3yFSbaw+W
86EjiLZV9C5WFCti1mDMh1mawyy1rqKOM5a02nlotPQAV5cCtsQwbuWb1T6956t+
+Nd9pyqCV1EDHXjl097mMrQBbZ3qy09rbNUidcSnG588SfdAKVYKnYnSaKYhVu0+
Td6j4fdRjq8teqpI1npS03GApeKLZPpmnJH/H12l/0Pf+II4Qr8Kd9WnY/wt7eST
pn3DhC44f4zmBD0AUTFu93278Df2UoGa0Oo3OQQJSdl+xZspiAM=
=cz/E
-----END PGP SIGNATURE-----

--6Th29Dm9mz74--
