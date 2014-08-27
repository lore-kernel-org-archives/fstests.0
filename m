Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39363 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaH0G7O convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Aug 2014 02:59:14 -0400
MIME-Version: 1.0
In-Reply-To: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
Date: Wed, 27 Aug 2014 10:59:13 +0400
Message-ID: <CAKywueTQeA4mi-54Bsz3GgY7ykw3-pDNSfSkXn=tDvPnDzPa3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] CIFS support for XFS test suite
From: Pavel Shilovsky <pshilovsky@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

2014-08-27 0:28 GMT+04:00 Pavel Shilovsky <pshilovsky@samba.org>:
> These are patches that adds CIFS support to XFS tests.
>
> The first patch changes generic/013 test to use mount options provided for $TEST_DEV for remount. The second patch adds "-cifs" command line argument and CIFS specific variables. The third patch disables tests that need POSIX behavior from filesystem for unix cifs mounts.
>
> With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.
>
> Pavel Shilovsky (3):
>   generic/013: encapsulate remount during cleanup
>   common: add cifs support
>   cifs: skip tests that need POSIX support for nounix mounts

Patches are also available in a git repository:
http://git.altlinux.org/people/piastry/public/?p=xfstests.git;a=shortlog;h=refs/heads/v2

-- 
Best regards,
Pavel Shilovsky.
