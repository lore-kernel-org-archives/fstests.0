Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:44077 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbaH1TIk convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 15:08:40 -0400
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org> <1409084918-17764-3-git-send-email-pshilovsky@samba.org> <20140828171802.GB20891@infradead.org>
In-Reply-To: <20140828171802.GB20891@infradead.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=koi8-r
Message-Id: <7D0F9460-0B84-4D36-B499-83DA9C334198@gmail.com>
Content-Transfer-Encoding: 8BIT
From: Pavel Shilovsky <piastryyy@gmail.com>
Subject: Re: [PATCH v2 2/3] common: add cifs support
Date: Thu, 28 Aug 2014 23:08:39 +0400
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Shilovsky <pshilovsky@samba.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

>> 28 авг. 2014 г., в 21:18, Christoph Hellwig <hch@infradead.org> написал(а):
>> 
>> On Wed, Aug 27, 2014 at 12:28:37AM +0400, Pavel Shilovsky wrote:
>> +    - You can explicitly specify NFS or CIFS, otherwise the filesystem type will
>> +      be autodetected from $TEST_DEV:
>>      ./check -nfs [test(s)]
> 
> Can you take care of mentioning tmpfs as well, looks like it didn't get
> added here when support was added.

Ok, will add it.

> 
>>   ;;
>> +    cifs)
>> +    # Don't know how to check a CIFS filesystem, yet.
>> +    ;;
> 
> Will we ever find a way to sanity check a cifs fs? :)
> 
> Otherwise looks fine to me.

Probably some day we will be able to run fsck checks on the remote server through a specific rpc.

Thank you for the review - will repost the series.

--
Best regards,
Pavel Shilovsky.

