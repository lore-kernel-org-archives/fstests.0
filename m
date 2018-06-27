Received: from mail.cn.fujitsu.com ([183.91.158.132]:2730 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933580AbeF0It2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:49:28 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9867B4B41EF8
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 16:49:17 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH 0/3] use sys/xattr.h instead of attr/xattr.h
Date: Wed, 27 Jun 2018 16:49:10 +0800
Message-ID: <20180627084913.4730-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The attr v2.4.48 has removed <attr/xattr.h>, so remove the check for the
<attr/xattr.h>, and use <sys/xattr.h> instead in fsstress and t_immutable.

Lu Fengqi (3):
  fsstress: use sys/xattr.h instead of attr/xattr.h
  src/t_immutable: use sys/xattr.h instead of attr/xattr.h
  build: remove <attr/xattr.h> check

 configure.ac          |  1 -
 ltp/fsstress.c        |  2 +-
 m4/package_attrdev.m4 | 11 -----------
 src/t_immutable.c     |  2 +-
 4 files changed, 2 insertions(+), 14 deletions(-)

-- 
2.18.0



