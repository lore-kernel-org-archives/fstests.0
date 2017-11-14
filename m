Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:51902 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKNBJw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Nov 2017 20:09:52 -0500
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 85C54AC009C
        for <fstests@vger.kernel.org>; Tue, 14 Nov 2017 10:09:45 +0900 (JST)
Received: from g01jpexchkw35.g01.fujitsu.local (unknown [10.0.193.4])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id E40DF3286A4
        for <fstests@vger.kernel.org>; Tue, 14 Nov 2017 10:09:44 +0900 (JST)
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH 0/1] small fix for newer util-linux
Message-ID: <7a255645-5148-cd45-c0f7-1645982ca4e9@jp.fujitsu.com>
Date: Tue, 14 Nov 2017 10:09:40 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello, 

I noticed util-linux 2.30 has changed some output messages
and therefore overlay/035 falsely fails.

I checked btrfs/generic/overlay and found the error only for this
(though some are skipped), so just modify the overlay/035.

If there exists more general way to handle the problem, please ignore this.

Regards,

Tomohiro Misono (1):
 overlay/035: small fix for newer util-linux

 tests/overlay/035 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.13.6


