Return-Path: <SRS0=sDCH=Z4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B3C43603
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Dec 2019 06:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723C22467A
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Dec 2019 06:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBpipAmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLFGpi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:45:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfLFGph (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Dec 2019 01:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575614735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfrnWH4bA8+VxhkSeceVqZY34CTNxvAup+gxuDG3srI=;
        b=DBpipAmnb/QRlU3ekKfI1wdDuyA9uCCtC0JjauDymqUF5AE7lUgCvRAFF1v0AC1TEJRRTE
        LaM4hJAh11atEK1B4/vAWMgBklOfSHHobnbhRw8nB4H2kE+/aAVWwGUF6S8+r3o6WuMMWI
        DuifnVjR00maOSVw3ncQRpOuMcvaKOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-54LGnq4fPQaQo5zbgB4zIA-1; Fri, 06 Dec 2019 01:45:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093D51005502;
        Fri,  6 Dec 2019 06:45:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0152B60F88;
        Fri,  6 Dec 2019 06:45:30 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E54991809563;
        Fri,  6 Dec 2019 06:45:30 +0000 (UTC)
Date:   Fri, 6 Dec 2019 01:45:30 -0500 (EST)
From:   Xiaoli Feng <xifeng@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
Message-ID: <1894952702.20019430.1575614730624.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191204161053.GF7328@magnolia>
References: <20191204080423.27295-1-xifeng@redhat.com> <20191204161053.GF7328@magnolia>
Subject: Re: [PATCH v1] xfs/148: fix some errors for output
MIME-Version: 1.0
X-Originating-IP: [10.72.12.224, 10.4.195.14]
Thread-Topic: xfs/148: fix some errors for output
Thread-Index: xgRPwOkSJcULcSxED674cMSEWQ4dzA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 54LGnq4fPQaQo5zbgB4zIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

----- Original Message -----
> From: "Darrick J. Wong" <darrick.wong@oracle.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Thursday, December 5, 2019 12:10:53 AM
> Subject: Re: [PATCH v1] xfs/148: fix some errors for output
> 
> On Wed, Dec 04, 2019 at 04:04:23PM +0800, XiaoLi Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> > 
> > When disable crc, the extended attributes display is different for
> > "attr -l". And there is no quotes when ls no-exist file in RHEL7. eg.
> > RHEL7:
> > ls: cannot access file: No such file or directory
> > RHEL8:
> > ls: cannot access 'file': No such file or directory
> > 
> > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> > ---
> >  tests/xfs/148     |  2 +-
> >  tests/xfs/148.out | 17 +++++++++--------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tests/xfs/148 b/tests/xfs/148
> > index 42cfdab0..1203edd9 100755
> > --- a/tests/xfs/148
> > +++ b/tests/xfs/148
> > @@ -79,7 +79,7 @@ access_stuff() {
> >  	$ATTR_PROG -l $testfile
> >  
> >  	for name in "${test_names[@]}"; do
> > -		ls "$testdir/f_$name"
> > +		ls "$testdir/f_$name" 2>&1 | sed -e "s/'//g"
> >  		$ATTR_PROG -g "a_$name" $testfile
> >  	done
> >  }
> > diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> > index c301ecb6..b1bea98a 100644
> > --- a/tests/xfs/148.out
> > +++ b/tests/xfs/148.out
> > @@ -4,10 +4,11 @@ f_another
> >  f_are_bad_for_you
> >  f_something
> >  f_too_many_beans
> > -Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > -Attribute "a_too_many_beans" has a 3 byte value for
> > TEST_DIR/mount-148/testfile
> >  Attribute "a_are_bad_for_you" has a 3 byte value for
> >  TEST_DIR/mount-148/testfile
> > +Attribute "a_too_many_beans" has a 3 byte value for
> > TEST_DIR/mount-148/testfile
> >  Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> > +Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > +Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
> 
> The single-quot filter part is fine, but this change in the golden
> output doesn't reflect that...
> 
> --D

Just found that you already sent a patch to fix "attr -l" output order. It's better.
And sorry, I didn't understand well about "but this change in the golden output doesn't
reflect that". I tested it on RHEL8, it's pass.

> 
> >  TEST_DIR/mount-148/testdir/f_something
> >  Attribute "a_something" had a 3 byte value for
> >  TEST_DIR/mount-148/testfile:
> >  heh
> > @@ -20,10 +21,10 @@ heh
> >  TEST_DIR/mount-148/testdir/f_another
> >  Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
> >  heh
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or
> > directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or
> > directory
> >  attr_get: No data available
> >  Could not get "a_too_many" for TEST_DIR/mount-148/testfile
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such
> > file or directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such
> > file or directory
> >  attr_get: No data available
> >  Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> >  ++ ACCESSING BAD METADATA
> > @@ -33,18 +34,18 @@ attr_list: Structure needs cleaning
> >  TEST_DIR/mount-148/testdir/f_something
> >  Attribute "a_something" had a 3 byte value for
> >  TEST_DIR/mount-148/testfile:
> >  heh
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many_beans': No such
> > file or directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many_beans: No such
> > file or directory
> >  attr_get: No data available
> >  Could not get "a_too_many_beans" for TEST_DIR/mount-148/testfile
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad_for_you': No such
> > file or directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad_for_you: No such
> > file or directory
> >  attr_get: No data available
> >  Could not get "a_are_bad_for_you" for TEST_DIR/mount-148/testfile
> >  TEST_DIR/mount-148/testdir/f_another
> >  Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
> >  heh
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or
> > directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or
> > directory
> >  attr_get: No data available
> >  Could not get "a_too_many" for TEST_DIR/mount-148/testfile
> > -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such
> > file or directory
> > +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such
> > file or directory
> >  Attribute "a_are_bad/for_you" had a 3 byte value for
> >  TEST_DIR/mount-148/testfile:
> >  heh
> > --
> > 2.18.1
> > 
> 
> 

