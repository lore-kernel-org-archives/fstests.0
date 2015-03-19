Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:8801 "EHLO
	mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbbCSP7H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Mar 2015 11:59:07 -0400
Received: from pps.filterd (m0075029.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.14.5/8.14.5) with SMTP id t2JFndPM022344
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2015 11:59:07 -0400
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com [209.85.213.179])
	by mx0b-00003501.pphosted.com with ESMTP id 1t7yydgfa4-3
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2015 11:59:07 -0400
Received: by mail-ig0-f179.google.com with SMTP id qf9so27207878igb.1
        for <fstests@vger.kernel.org>; Thu, 19 Mar 2015 08:59:07 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Mar 2015 09:59:06 -0600
Message-ID: <CAKdFiL4A0yQBL63XbtG_Dvm_eGB11GDqbDQJRQVC91_HDzrKvQ@mail.gmail.com>
Subject: SMRFFS - EXT4, and a few stack changes
From: Adrian Palmer <adrian.palmer@seagate.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, ext4 development <linux-ext4@vger.kernel.org>, fstests@vger.kernel.org, linux-raid@ver.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, linux-ide@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi all;

As some have been asking, I've posted some proof-of-concept code at
(https://github.com/Seagate/SMR_FS-EXT4).

Let me know any feedback.  We're in the process of planning out the
schedule moving forward.

I'm spamming everyone because of the extent of the changes we've touched.

I'm also copying the RAID list because I want to start a discussion
about planning RAID solutions on SMR.



Adrian Palmer
Firmware Engineer II
R&D Firmware
Seagate, Longmont Colorado
720-684-1307
adrian.palmer@seagate.com
