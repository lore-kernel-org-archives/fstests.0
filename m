Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E6C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhLSQjr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 11:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLSQjr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 11:39:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D7C061574
        for <fstests@vger.kernel.org>; Sun, 19 Dec 2021 08:39:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t18so15094971wrg.11
        for <fstests@vger.kernel.org>; Sun, 19 Dec 2021 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=SYEr0b9y1/hYLr5FYJhO67cDwHizARNoX0AZ6oihuts=;
        b=V2+xQ72jNWqHkcXWCKu2/2TArY5MMiXtv57ysHkA4DNcZePIDoE4eqiVk7zQwUyl5w
         heSH2q/eQrA90HWGefqD4S+3XFrpaxQzjT0Iq290gdy4QamNyeJvo3mfzK/DpUTSURFP
         KFb8B2c2uzG4nRwmuwHeGpaSTERVZlKkelk6iaQ4YJRcIOrjfZGrPuDTEjH3rQWd0hRd
         Mvcu/3rec72Uql8KVZkVy8vePfTBzGT2JB7jHLxP8Y+UTZd3oE+lx7TPA8kv0bSObLUH
         3LAEj4+F6vuxDk3pBuNxoq5n5jFyNT77Eaz90hhiEUxd/xhGLCjqy6deB1+xIIg4AbMO
         sx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=SYEr0b9y1/hYLr5FYJhO67cDwHizARNoX0AZ6oihuts=;
        b=aSZhTbL+pYi+St7ppFHpMhMZqze9xt2A6QfgR7LRCupZq7ytAg3/ofWA7ELPE5rN40
         eXqRPTD5kyvaSdfIZVpZc0K/OtuY1jgYyybAfAGAKBv2xIz3VCXr37pSzs1XgLWDuzQz
         NUFYMHkWiIuMf6qGIyddoZTyePR3gfpJFqT4mgJMY03p4kOq8t4qNlcH7Q/XtvTO/V2U
         W1zDyQCcPnQWwlySvOvQs5EuuwMTLgu6xiRMZSIy00GZ6riyZJbMxZDt6n+a1eruP8rb
         0lVDPB//aVThrj2znnOdQL3Fp+5aCfHGd3vnJBFAde2abeNkkgdHww/UZb2fyUVeSYbi
         NV1w==
X-Gm-Message-State: AOAM530pKjM4prNIKJrJKWg2mFZKGeNA7phbr5Wv3/47BpuvV4UUSVJt
        7BOlzkV5Y3YtZ/u80p/kjzeq7ReoGOJWP9ay
X-Google-Smtp-Source: ABdhPJyz5dcCwyxYl8t0TOfRlKlP1anZBYGKklpp0zW/tTLTLqRBoV0noWKcRSCXlfSURLC2/mIhhQ==
X-Received: by 2002:adf:cd8a:: with SMTP id q10mr9841445wrj.164.1639931985231;
        Sun, 19 Dec 2021 08:39:45 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id b19sm18272003wmb.38.2021.12.19.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 08:39:44 -0800 (PST)
Message-ID: <61bf6050.1c69fb81.67781.7d23@mx.google.com>
Date:   Mon, 20 Dec 2021 00:39:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 58e358032ac1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fwE7MUzCbnt6"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--fwE7MUzCbnt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. A small update that contains two new tests and one fix,
the new tests all pass with latest v5.16-rc5 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

58e358032ac1 ext4: illegal memory access caused by quota index information error

New commits:

Brian Foster (1):
      [0d04edb16471] xfs: test COW writeback failure when overlapping non-shared blocks

Sun Ke (1):
      [58e358032ac1] ext4: illegal memory access caused by quota index information error

Theodore Ts'o (1):
      [90d132ee44b7] common/filter: add _filter_bash()


Code Diffstat:

 common/filter      | 11 +++++++++
 tests/ext4/055     | 54 +++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/055.out |  2 ++
 tests/generic/572  | 33 +++++++++++++++------------
 tests/xfs/542      | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/542.out  |  2 ++
 6 files changed, 155 insertions(+), 14 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--fwE7MUzCbnt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmG/YDMACgkQJlKqKVyP
52M+Qg/+N+EmOS9jNG0sq0+4SaYOwmEOPFq9+OGl9zJfe1BXkd3l8zKf6UxmbK/b
wu8sTkGt125iHYjghLNFRR2H1BWYVYM7EJeg/ZKCdk0bqAqi7yDqzurZN3PQKu/G
nQD4fbhEt10EJH9or/1K9HtlQk9t894oQJOIyEy9ETM61gejhy0MURVUAbMSs7KP
GUtqX7DWP1pRw0gtacOFXFA28qCqRR8ekg2qwNXa4SGNT/TxQB6NtxkCsGMsK7mf
Brx2rX3TI0mqCugz/2eWz7Ar/MPXuaijw9EX44EjbP5llKjvMqAqifEjqSubZ7c6
JN8EeGw4MY26wD0A/y3NA5wT8rk8D92Ek8fQUP3vZPXYGePMw6lEht1GPpGEyAGa
tAIQasBcRJOap8WrTPLlHvBBmqgG5ZuAAgkEdFBsMdlXfp5d+4pYSgvRkzFJ9JgM
kGjZZIZ9Yi7TAzKZ4ask1GDuJ9oA1smrqw9bT2AKXOmx2WU1HKkouz3rbtru9tCF
qxYUEodw5GcAf0HvXSVz2dt0Exw6AKWLQZFdnDRarQO+N8fPLShDXYRvp+T24cD6
rwSox6sysmxS+kpvGR4dUnNeS9q2/13FRo97KRgqPZ0aMLgomQa0aII0FP/WpZN3
mNNFuoftVFP+z48yGBNVKp7CNqgNlDTEk2ABwgvE4AfwF0n1cs8=
=JyfP
-----END PGP SIGNATURE-----

--fwE7MUzCbnt6--
