Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59150 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbaH1Suj convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 14:50:39 -0400
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org> <1409084918-17764-2-git-send-email-pshilovsky@samba.org> <20140828170849.GA20891@infradead.org>
In-Reply-To: <20140828170849.GA20891@infradead.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=koi8-r
Message-Id: <5F4BB2B2-2286-4EC0-B70C-F5BC107DA513@gmail.com>
Content-Transfer-Encoding: 8BIT
From: Pavel Shilovsky <piastryyy@gmail.com>
Subject: Re: [PATCH v2 1/3] generic/013: encapsulate remount during cleanup
Date: Thu, 28 Aug 2014 22:50:36 +0400
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Shilovsky <pshilovsky@samba.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>



>> 28 авг. 2014 г., в 21:08, Christoph Hellwig <hch@infradead.org> написал(а):
>> 
>> On Wed, Aug 27, 2014 at 12:28:36AM +0400, Pavel Shilovsky wrote:
>> The existing code calls remount for $TEST_DEV with constantly defined
>> mount options. This can fail if a user specifies different mount options.
>> Fix this by using new _test_remount() call that remounts $TEST_DEV.
> 
> Looks technically correct, but I still wonder why it's needed at all,
> I can't see anything in the test that would remount the filesystem
> read-only.  git history isn't a help here as the remount goes back to
> the first public revision.

Anyway I think it won't hurt to apply this patch at first and then probably remove this part at all.

--
Best regards,
Pavel Shilovsky.