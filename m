Received: from mail.cn.fujitsu.com ([183.91.158.132]:45803 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752035AbeF0KTC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 06:19:02 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B41A848029E8
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 18:18:58 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH v2 0/3] use sys/xattr.h instead of attr/xattr.h
Date: Wed, 27 Jun 2018 18:18:51 +0800
Message-ID: <20180627101854.13158-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The attr v2.4.48 has removed <attr/xattr.h>, so remove the check for the
<attr/xattr.h>, and use <sys/xattr.h> instead in t_immutable. And, It's
timing to remove useless xattr.h from fsstress.

Changelog:
v2: remove useless xattr.h from fsstress

Lu Fengqi (3):
  fsstress: remove include <attr/xattr.h>
  src/t_immutable: use sys/xattr.h instead of attr/xattr.h
  build: remove <attr/xattr.h> check

 configure.ac          |  1 -
 ltp/fsstress.c        |  3 ---
 m4/package_attrdev.m4 | 11 -----------
 src/t_immutable.c     |  2 +-
 4 files changed, 1 insertion(+), 16 deletions(-)

-- 
2.18.0



